<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="categories" value="${requestScope.categories}" />
<c:if test="${empty categories}">
    <jsp:forward page="/journalist/create-article" />
</c:if>

<c:set var="u" value="${requestScope.currentUser}" />
<c:set var="art" value="${requestScope.article}" />
<c:set var="artId" value="${not empty art ? art.id : 0}" />
<c:set var="artTitle" value="${not empty art.title ? art.title : ''}" />
<c:set var="artContent" value="${not empty art.content ? art.content : ''}" />
<c:set var="artSummary" value="${not empty art.summary ? art.summary : ''}" />
<c:set var="artImage" value="${not empty art.imageUrl ? art.imageUrl : ''}" />
<c:set var="artCatId" value="${not empty art ? art.categoryId : 0}" />

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="artImageDisplay" value="${artImage}" />
<c:if test="${not empty artImageDisplay and !fn:startsWith(artImageDisplay, 'http')}">
    <c:choose>
        <c:when test="${fn:startsWith(artImageDisplay, '/')}">
            <c:set var="artImageDisplay" value="${ctx}${artImageDisplay}" />
        </c:when>
        <c:otherwise>
            <c:set var="artImageDisplay" value="${ctx}/${artImageDisplay}" />
        </c:otherwise>
    </c:choose>
</c:if>

<!DOCTYPE html>
<html class="dark" lang="vi">
<head>
    <jsp:include page="components/head.jsp" />
    <title>${artId > 0 ? "Chỉnh sửa bài viết" : "Tạo bài viết mới"}</title>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/6.8.4/tinymce.min.js"></script>
    <style>
        body { font-family: "Work Sans", sans-serif; }

        /* Scrollbar */
        .editor-container::-webkit-scrollbar { width: 5px; }
        .editor-container::-webkit-scrollbar-thumb { background: rgba(99,102,241,.3); border-radius: 10px; }
        .editor-container::-webkit-scrollbar-track { background: transparent; }

        /* ── TinyMCE: no border, no shadow ── */
        .tox-tinymce {
            border: none !important;
            border-radius: 0 !important;
            box-shadow: none !important;
            background: transparent !important;
        }
        .tox .tox-edit-area {
            background: transparent !important;
            border: none !important;
        }
        .tox .tox-edit-area__iframe { background: transparent !important; }
        .tox .tox-editor-header {
            background: transparent !important;
            border: none !important;
            box-shadow: none !important;
        }
        /* Header action buttons - nằm trong header, bên trái notification */
        #headerActions {
            display: flex;
            align-items: center;
            gap: 8px;
            transition: opacity .3s ease;
        }
        body.focus-mode #headerActions {
            display: none;
        }
        /* Toolbar cố định trên cùng, full width */
        .tox .tox-editor-header {
            position: fixed !important;
            top: 64px !important;
            left: 288px !important;
            right: 0 !important;
            width: auto !important;
            z-index: 9999 !important;
            background: transparent !important;
            border: none !important;
            box-shadow: none !important;
            padding: 0 !important;
            transition: left .3s ease, top .3s ease !important;
        }
        /* Khi focus mode: toolbar full width, sát top */
        body.focus-mode .tox .tox-editor-header {
            left: 0 !important;
            top: 0 !important;
        }
        /* Menubar */
        .tox .tox-menubar {
            background: rgba(8,13,20,0.97) !important;
            backdrop-filter: blur(16px) !important;
            -webkit-backdrop-filter: blur(16px) !important;
            border-bottom: 1px solid rgba(255,255,255,.05) !important;
            padding: 2px 16px !important;
        }
        .tox .tox-mbtn { color: #94a3b8 !important; font-size: 11px !important; font-weight: 500 !important; border-radius: 6px !important; }
        .tox .tox-mbtn:hover { background: rgba(99,102,241,.18) !important; color: #e2e8f0 !important; }
        /* Toolbar rows */
        .tox .tox-toolbar-overlord,
        .tox .tox-toolbar__primary {
            background: rgba(10,15,20,0.95) !important;
            backdrop-filter: blur(16px) !important;
            -webkit-backdrop-filter: blur(16px) !important;
            border-bottom: 1px solid rgba(99,102,241,.25) !important;
            border-radius: 0 !important;
            padding: 4px 16px !important;
            margin: 0 !important;
            width: 100% !important;
            box-shadow: 0 4px 24px rgba(0,0,0,.4) !important;
        }
        .tox .tox-tbtn { border-radius: 6px !important; color: #94a3b8 !important; transition: background .15s, color .15s !important; }
        .tox .tox-tbtn:hover { background: rgba(99,102,241,.18) !important; color: #e2e8f0 !important; }
        .tox .tox-tbtn--enabled, .tox .tox-tbtn--active { background: rgba(99,102,241,.28) !important; color: #a5b4fc !important; }
        .tox .tox-tbtn svg { fill: currentColor !important; }
        .tox .tox-tbtn__select-label { color: #94a3b8 !important; font-size: 11px !important; }
        .tox .tox-tbtn__select-chevron svg { fill: #64748b !important; }
        .tox .tox-toolbar__group:not(:last-of-type) { border-right: 1px solid rgba(255,255,255,.08) !important; }
        /* Statusbar */
        .tox .tox-statusbar { background: transparent !important; border: none !important; color: #334155 !important; font-size: 10px !important; }

        /* ── Light theme override ── */
        html:not(.dark) .tox .tox-menubar {
            background: #f1f5f9 !important;
            border-bottom: 1px solid #e2e8f0 !important;
        }
        html:not(.dark) .tox .tox-mbtn { color: #475569 !important; }
        html:not(.dark) .tox .tox-mbtn:hover { background: rgba(99,102,241,.12) !important; color: #1e293b !important; }
        html:not(.dark) .tox .tox-toolbar-overlord,
        html:not(.dark) .tox .tox-toolbar__primary {
            background: #f8fafc !important;
            backdrop-filter: none !important;
            border-bottom: 1px solid #e2e8f0 !important;
            box-shadow: 0 2px 8px rgba(0,0,0,.08) !important;
        }
        html:not(.dark) .tox .tox-tbtn { color: #475569 !important; }
        html:not(.dark) .tox .tox-tbtn:hover { background: rgba(99,102,241,.1) !important; color: #1e293b !important; }
        html:not(.dark) .tox .tox-tbtn--enabled,
        html:not(.dark) .tox .tox-tbtn--active { background: rgba(99,102,241,.15) !important; color: #4f46e5 !important; }
        html:not(.dark) .tox .tox-tbtn svg { fill: currentColor !important; }
        html:not(.dark) .tox .tox-tbtn__select-label { color: #475569 !important; }
        html:not(.dark) .tox .tox-toolbar__group:not(:last-of-type) { border-right: 1px solid #e2e8f0 !important; }
        html:not(.dark) .tox .tox-statusbar { color: #94a3b8 !important; }
        /* Dropdowns */
        .tox .tox-collection--list, .tox .tox-menu, .tox-tinymce-aux, .tox .tox-pop, .tox .tox-dialog-wrap { z-index: 99999 !important; }
        .tox.tox-tinymce-aux { z-index: 99999 !important; }
        .tox .tox-collection--list .tox-collection__group { max-height: 60vh !important; overflow-y: auto !important; }

        /* Sidebar input focus */
        .s-input:focus {
            border-color: rgba(99,102,241,.5) !important;
            box-shadow: 0 0 0 3px rgba(99,102,241,.12) !important;
            outline: none !important;
        }

        /* Select danh mục — đồng bộ theme tối */
        #categorySelect { color-scheme: dark; }
        #categorySelect option { background-color: #1e293b; color: #e2e8f0; }

        /* Lightbox */
        #lightbox {
            display: none; position: fixed; inset: 0; z-index: 9999999;
            background: rgba(0,0,0,.92); backdrop-filter: blur(6px);
            align-items: center; justify-content: center;
        }
        #lightbox.open { display: flex; }
        #lightbox img {
            max-width: 90vw; max-height: 88vh;
            border-radius: 12px;
            box-shadow: 0 32px 80px rgba(0,0,0,.8);
            object-fit: contain;
        }
        #previewModal {
            display: none;
            position: fixed; inset: 0; z-index: 999999;
            background: rgba(0,0,0,.75);
            backdrop-filter: blur(4px);
        }
        #previewModal.open { display: flex; align-items: center; justify-content: center; }
        #previewBox {
            background: #0f172a;
            border: 1px solid rgba(99,102,241,.3);
            border-radius: 16px;
            width: 90vw; max-width: 860px;
            max-height: 88vh;
            display: flex; flex-direction: column;
            box-shadow: 0 24px 64px rgba(0,0,0,.6);
            overflow: hidden;
        }
        #previewContent {
            flex: 1; overflow-y: auto; padding: 48px 56px;
            font-family: "Work Sans", sans-serif;
            color: #cbd5e1; line-height: 1.9; font-size: 16px;
        }
        #previewContent h1,#previewContent h2,#previewContent h3 { color: #f1f5f9; margin: 1.4em 0 .6em; }
        #previewContent p { margin-bottom: 1em; }
        #previewContent::-webkit-scrollbar { width: 5px; }
        #previewContent::-webkit-scrollbar-thumb { background: rgba(99,102,241,.3); border-radius: 10px; }
    </style>
</head>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen overflow-hidden">
<div class="flex h-screen">

    <%-- ── Sidebar ─────────────────────────────────────────────── --%>
    <aside id="sidebarPanel" class="w-72 bg-white dark:bg-surface-dark border-r border-slate-200 dark:border-border-dark flex flex-col shrink-0" style="transition: width .3s ease, opacity .3s ease;">

        <%-- Header --%>
        <div class="px-4 py-3.5 border-b border-slate-200 dark:border-border-dark flex items-center justify-between">
            <div class="flex items-center gap-2.5">
                <div class="size-8 rounded-lg bg-indigo-600 flex items-center justify-center shadow shadow-indigo-500/40 shrink-0">
                    <span class="material-symbols-outlined text-white" style="font-size:17px">edit_note</span>
                </div>
                <div>
                    <p class="text-[11px] font-bold tracking-widest text-slate-700 dark:text-slate-100 uppercase leading-none">
                        ${artId > 0 ? "Chỉnh Sửa" : "Tạo Bài Viết"}
                    </p>
                    <p class="text-[10px] text-slate-400 dark:text-slate-500 mt-0.5 leading-none">
                        ${artId > 0 ? "Cập nhật nội dung" : "Bài viết mới"}
                    </p>
                </div>
            </div>
            <button onclick="toggleFocusMode()" title="Thu gọn sidebar"
                    class="size-7 rounded-md text-slate-400 hover:text-slate-200 hover:bg-white/[0.06] transition-all flex items-center justify-center shrink-0">
                <span class="material-symbols-outlined" style="font-size:18px">keyboard_double_arrow_left</span>
            </button>
        </div>

        <%-- Body --%>
        <div class="flex-1 overflow-y-auto py-5 px-4 space-y-5">

            <%-- Danh mục --%>
            <section>
                <label class="flex items-center gap-1.5 text-[10px] font-bold uppercase tracking-[0.12em] text-slate-400 dark:text-slate-500 mb-1.5">
                    <span class="material-symbols-outlined" style="font-size:13px">folder_open</span>
                    Danh mục
                </label>
                <div class="relative">
                    <select id="categorySelect"
                            class="s-input w-full appearance-none bg-slate-50 dark:bg-white/[0.04] border border-slate-200 dark:border-border-dark rounded-lg pl-3 pr-8 py-2.5 text-xs text-slate-800 dark:text-slate-200 transition-all cursor-pointer outline-none">
                        <option value="">-- Chọn danh mục --</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}" ${cat.id == artCatId ? 'selected' : ''}>
                                ${cat.name}
                            </option>
                        </c:forEach>
                    </select>
                    <span class="material-symbols-outlined absolute right-2.5 top-1/2 -translate-y-1/2 text-slate-400 pointer-events-none" style="font-size:16px">expand_more</span>
                </div>
            </section>

            <%-- Ảnh đại diện --%>
            <section>
                <label class="flex items-center gap-1.5 text-[10px] font-bold uppercase tracking-[0.12em] text-slate-400 dark:text-slate-500 mb-1.5">
                    <span class="material-symbols-outlined" style="font-size:13px">image</span>
                    Ảnh đại diện
                </label>

                <%-- Upload zone --%>
                <div id="uploadZone"
                     onclick="document.getElementById('fileInput').click()"
                     ondragover="event.preventDefault();this.classList.add('!border-indigo-500')"
                     ondragleave="this.classList.remove('!border-indigo-500')"
                     ondrop="handleDrop(event)"
                     class="w-full border-2 border-dashed border-slate-300 dark:border-slate-600 rounded-lg p-4 flex flex-col items-center gap-1.5 cursor-pointer hover:border-indigo-500 transition-all group">
                    <span class="material-symbols-outlined text-slate-400 group-hover:text-indigo-400 transition-colors" style="font-size:26px">cloud_upload</span>
                    <p class="text-[11px] text-slate-400 text-center leading-relaxed">
                        Kéo thả hoặc <span class="text-indigo-400 font-semibold">chọn ảnh</span>
                    </p>
                    <p class="text-[10px] text-slate-500">JPG, PNG, WEBP · Tối đa 10MB</p>
                </div>
                <input id="fileInput" type="file" accept="image/*" class="hidden" onchange="uploadImage(this)" />

                <%-- Progress --%>
                <div id="uploadProgress" class="hidden mt-2 space-y-1">
                    <span class="text-[10px] text-slate-400" id="uploadStatus">Đang tải lên...</span>
                    <div class="w-full bg-slate-200 dark:bg-white/[0.06] rounded-full h-1">
                        <div id="uploadBar" class="bg-indigo-500 h-1 rounded-full transition-all duration-300" style="width:0%"></div>
                    </div>
                </div>

                <%-- Input ẩn để giữ path ảnh (không cho nhập URL thủ công nữa) --%>
                <input id="imageUrlInput" type="hidden"
                       value="${artImage}"/>

                <%-- Preview --%>
                <div id="imgPreviewBox" class="mt-2 rounded-lg overflow-hidden border border-slate-200 dark:border-border-dark relative group/img ${empty artImage ? 'hidden' : ''}">
                    <img id="imgPreviewEl" src="${artImageDisplay}" alt="Preview"
                         onclick="openLightbox(this.src)"
                         class="w-full h-28 object-cover cursor-zoom-in"
                         onerror="document.getElementById('imgPreviewBox').classList.add('hidden')" />
                    <div class="absolute inset-0 bg-black/0 group-hover/img:bg-black/20 transition-all pointer-events-none flex items-center justify-center">
                        <span class="material-symbols-outlined text-white opacity-0 group-hover/img:opacity-100 transition-all" style="font-size:22px">zoom_in</span>
                    </div>
                    <button onclick="removeImage()" title="Xóa ảnh"
                            class="absolute top-1.5 right-1.5 size-6 bg-black/60 hover:bg-red-600 rounded-full flex items-center justify-center opacity-0 group-hover/img:opacity-100 transition-all">
                        <span class="material-symbols-outlined text-white" style="font-size:14px">close</span>
                    </button>
                </div>
            </section>

            <div class="border-t border-slate-100 dark:border-border-dark"></div>

            <%-- Tóm tắt --%>
            <section>
                <label class="flex items-center gap-1.5 text-[10px] font-bold uppercase tracking-[0.12em] text-slate-400 dark:text-slate-500 mb-1.5">
                    <span class="material-symbols-outlined" style="font-size:13px">short_text</span>
                    Tóm tắt bài viết
                </label>
                <textarea id="summaryInput" rows="5" maxlength="300"
                          placeholder="Nhập tóm tắt ngắn gọn về nội dung bài viết..."
                          oninput="document.getElementById('sumCount').textContent=this.value.length"
                          class="s-input w-full bg-slate-50 dark:bg-white/[0.04] border border-slate-200 dark:border-border-dark rounded-lg px-3 py-2.5 text-xs text-slate-800 dark:text-slate-200 resize-none transition-all leading-relaxed">${artSummary}</textarea>
                <p class="text-[10px] text-slate-500 mt-1 text-right">
                    <span id="sumCount">${fn:length(artSummary)}</span>&nbsp;/&nbsp;300
                </p>
            </section>

        </div>
    </aside>

    <%-- ── Main Editor ─────────────────────────────────────────── --%>
    <main class="flex-1 flex flex-col relative bg-white dark:bg-[#0a0f14] overflow-hidden">

        <%-- Header --%>
        <jsp:include page="components/header.jsp">
            <jsp:param name="pageTitle" value="${artId > 0 ? 'Chỉnh sửa Bài viết' : 'Tạo Bài viết Mới'}" />
            <jsp:param name="backUrl" value="${pageContext.request.contextPath}/journalist/articles" />
        </jsp:include>

        <%-- Action buttons được đặt trong header --%>
        <div id="headerActions">
            <button type="button" onclick="submitForm('draft')"
                    class="px-3 py-1.5 bg-white dark:bg-slate-800 border border-slate-200 dark:border-border-dark hover:border-indigo-500/50 text-slate-500 dark:text-slate-400 text-[10px] font-bold rounded-md transition-all uppercase tracking-widest">
                Lưu Nháp
            </button>
            <button type="button" onclick="openPreview()"
                    class="px-3 py-1.5 bg-white dark:bg-slate-800 border border-slate-200 dark:border-border-dark hover:border-indigo-500/50 text-slate-500 dark:text-slate-400 text-[10px] font-bold rounded-md transition-all flex items-center gap-1 uppercase tracking-widest">
                Xem trước
            </button>
            <button type="button" onclick="submitForm('submit')"
                    class="px-4 py-1.5 bg-primary hover:bg-primary/90 text-white text-[10px] font-bold rounded-md transition-all uppercase tracking-widest shadow-sm shadow-primary/20">
                Gửi Đánh giá
            </button>
        </div>

        <%-- Hidden form --%>
        <form id="articleForm" method="post" action="${ctx}/journalist/create-article" style="display:none">
            <input type="hidden" name="articleId"  id="f_articleId" value="${artId > 0 ? artId : ''}" />
            <input type="hidden" name="title"      id="f_title" />
            <input type="hidden" name="content"    id="f_content" />
            <input type="hidden" name="summary"    id="f_summary" />
            <input type="hidden" name="imageUrl"   id="f_imageUrl" />
            <input type="hidden" name="categoryId" id="f_categoryId" />
            <input type="hidden" name="action"     id="f_action" />
        </form>

        <%-- Scroll area — padding-top để tránh toolbar cố định --%>
        <div class="flex-1 overflow-y-auto editor-container px-8 py-10 lg:px-20 lg:py-12" style="padding-top: 220px;">
            <div class="max-w-3xl mx-auto space-y-8">

                <%-- Tiêu đề --%>
                <input id="titleInput"
                       class="w-full bg-transparent border-none focus:ring-0 text-4xl lg:text-5xl font-bold placeholder-slate-700 dark:text-white leading-tight outline-none"
                       placeholder="Nhập tiêu đề bài viết..."
                       type="text"
                       value="${artTitle}" />

                <%-- Author --%>
                <div class="flex items-center gap-3 py-4 border-y border-slate-100 dark:border-slate-800/60">
                    <div class="size-10 rounded-full bg-primary/10 flex items-center justify-center text-primary font-bold text-sm ring-1 ring-primary/20 shrink-0">
                        ${not empty u ? fn:substring(u.fullName, 0, 1) : '?'}
                    </div>
                    <div>
                        <p class="text-xs font-bold text-slate-900 dark:text-white">${u.fullName}</p>
                        <p class="text-[10px] text-slate-500 uppercase tracking-widest font-medium mt-0.5">Phóng viên / Biên tập</p>
                    </div>
                </div>

                <%-- TinyMCE --%>
                <textarea id="contentEditor" name="content">${not empty artContent ? artContent : ''}</textarea>

            </div>
        </div>

        <%-- Float buttons --%>
        <div id="floatBtns" class="fixed flex flex-col gap-3" style="right: 20px; z-index: 999999; top: 250px; transition: top .3s ease;">
            <button id="btnFullscreen" onclick="toggleFocusMode()" title="Chế độ tập trung"
                    class="size-10 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-full shadow-lg flex items-center justify-center hover:border-indigo-500/60 transition-all group">
                <span id="iconFullscreen" class="material-symbols-outlined text-slate-400 group-hover:text-indigo-400 transition-colors" style="font-size:18px">fullscreen</span>
            </button>
            <button id="btnTheme" onclick="toggleTheme()" title="Sáng / Tối"
                    class="size-10 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-full shadow-lg flex items-center justify-center hover:border-indigo-500/60 transition-all group">
                <span id="iconTheme" class="material-symbols-outlined text-slate-400 group-hover:text-indigo-400 transition-colors" style="font-size:18px">light_mode</span>
            </button>
        </div>

    </main>
</div>

<%-- ── Lightbox ─────────────────────────────────────────────────────── --%>
<div id="lightbox" onclick="closeLightbox()">
    <img id="lightboxImg" src="" alt="Xem ảnh" />
    <button onclick="closeLightbox()" style="position:fixed;top:20px;right:24px;z-index:10000000;"
            class="size-10 bg-white/10 hover:bg-white/20 rounded-full flex items-center justify-center transition-all">
        <span class="material-symbols-outlined text-white" style="font-size:20px">close</span>
    </button>
</div>

<%-- ── Preview Modal ─────────────────────────────────────────────── --%>
<div id="previewModal">
    <div id="previewBox">
        <%-- Modal header --%>
        <div class="flex items-center justify-between px-6 py-4 border-b border-slate-700/60 shrink-0">
            <div class="flex items-center gap-2.5">
                <span class="material-symbols-outlined text-indigo-400" style="font-size:18px">visibility</span>
                <span class="text-sm font-bold text-slate-200 uppercase tracking-widest">Xem trước bài viết</span>
            </div>
            <button onclick="closePreview()"
                    class="size-8 rounded-lg text-slate-400 hover:text-white hover:bg-white/[0.08] transition-all flex items-center justify-center">
                <span class="material-symbols-outlined" style="font-size:20px">close</span>
            </button>
        </div>
        <%-- Ảnh đại diện preview --%>
        <div id="previewHero" class="hidden shrink-0">
            <img id="previewHeroImg" src="" alt="" class="w-full h-52 object-cover" />
        </div>
        <%-- Nội dung --%>
        <div id="previewContent">
            <h1 id="previewTitle" class="text-3xl font-bold text-slate-100 mb-6 leading-tight"></h1>
            <div class="flex items-center gap-3 pb-6 mb-6 border-b border-slate-700/50">
                <div class="size-8 rounded-full bg-indigo-500/20 flex items-center justify-center text-indigo-400 font-bold text-sm ring-1 ring-indigo-500/25 shrink-0">
                    ${not empty u ? fn:substring(fn:toUpperCase(u.fullName), 0, 1) : '?'}
                </div>
                <div>
                    <p class="text-xs font-semibold text-slate-300">${not empty u ? u.fullName : ''}</p>
                    <p class="text-[10px] text-slate-500 uppercase tracking-wider">Biên tập viên</p>
                </div>
            </div>
            <div id="previewBody"></div>
        </div>
    </div>
</div>

<script>
    var _isDark = true;

    // ── TinyMCE ───────────────────────────────────────────────────────────────
    function initTinyMCE(darkMode) {
        if (typeof tinymce === 'undefined') return;
        tinymce.remove('#contentEditor');
        tinymce.init({
            selector: '#contentEditor',
            plugins: [
                'advlist', 'autolink', 'lists', 'link', 'image', 'charmap', 'anchor',
                'searchreplace', 'visualblocks', 'code', 'fullscreen',
                'insertdatetime', 'media', 'table', 'wordcount', 'emoticons',
                'codesample', 'hr', 'nonbreaking', 'pagebreak'
            ],
            images_upload_url: '${pageContext.request.contextPath}/api/upload',
            automatic_uploads: true,
            images_reuse_filename: false,
            file_picker_types: 'image',
            toolbar1:
                'undo redo | blocks fontfamily fontsize | ' +
                'bold italic underline strikethrough | forecolor backcolor | ' +
                'alignleft aligncenter alignright alignjustify',
            toolbar2:
                'bullist numlist outdent indent | ' +
                'link image media table | blockquote codesample code | ' +
                'charmap emoticons insertdatetime | hr pagebreak | ' +
                'searchreplace visualblocks | removeformat | fullscreen',
            toolbar_location: 'top',
            toolbar_mode: 'wrap',
            menubar: 'file edit view insert format tools table',
            skin: darkMode ? 'oxide-dark' : 'oxide',
            content_css: darkMode ? 'dark' : 'default',
            height: 480,
            min_height: 380,
            resize: true,
            branding: false,
            promotion: false,
            fontsize_formats: '10pt 11pt 12pt 14pt 16pt 18pt 20pt 24pt 28pt 36pt 48pt',
            font_family_formats:
                'Mặc định=inherit;Work Sans="Work Sans",sans-serif;' +
                'Arial=arial,helvetica,sans-serif;Times New Roman=times new roman,times,serif;' +
                'Georgia=georgia,palatino,serif;Courier New=courier new,courier,monospace;' +
                'Verdana=verdana,geneva,sans-serif;',
            block_formats: 'Đoạn văn=p; Tiêu đề 1=h1; Tiêu đề 2=h2; Tiêu đề 3=h3; Trích dẫn=blockquote; Code=pre',
            content_style: darkMode
                ? 'body{font-family:"Work Sans",sans-serif;font-size:16px;color:#cbd5e1;background:#0a0f14;line-height:1.9;padding:24px 36px;}'
                : 'body{font-family:"Work Sans",sans-serif;font-size:16px;color:#1e293b;background:#fff;line-height:1.9;padding:24px 36px;}',
            setup: function(ed) {
                ed.on('init', function() {
                    var aux = document.querySelector('.tox-tinymce-aux');
                    if (aux) aux.style.zIndex = '99999';
                });
                ed.on('OpenWindow', function() {
                    var aux = document.querySelector('.tox-tinymce-aux');
                    if (aux) aux.style.zIndex = '99999';
                });
            }
        });
    }

    // ── Bootstrap ─────────────────────────────────────────────────────────────
    document.addEventListener('DOMContentLoaded', function() {
        // Di chuyển các nút action vào slot trên header
        const slot = document.getElementById('headerExtraSlot');
        const actions = document.getElementById('headerActions');
        if (slot && actions) {
            slot.appendChild(actions);
        }

        var iconTheme = document.getElementById('iconTheme');
        // Theme is already applied by head.jsp
        initTinyMCE(document.documentElement.classList.contains('dark'));
        var sum = document.getElementById('summaryInput');
        if (sum) document.getElementById('sumCount').textContent = sum.value.length;

        // Auto-hide toasts
        setTimeout(() => {
            const toasts = document.querySelectorAll('#toast-success, #toast-error');
            toasts.forEach(t => {
                t.style.opacity = '0';
                t.style.transform = 'translateY(-20px)';
                t.style.transition = 'all 0.5s ease-out';
                setTimeout(() => t.remove(), 500);
            });
        }, 4000);
    });

    // ── Submit ────────────────────────────────────────────────────────────────
    function submitForm(action) {
        var title = document.getElementById('titleInput').value.trim();
        if (!title) { alert('Vui lòng nhập tiêu đề bài viết!'); document.getElementById('titleInput').focus(); return; }
        var content = (tinymce && tinymce.get('contentEditor'))
            ? tinymce.get('contentEditor').getContent()
            : document.getElementById('contentEditor').value;
        document.getElementById('f_title').value      = title;
        document.getElementById('f_content').value    = content;
        document.getElementById('f_summary').value    = document.getElementById('summaryInput').value;
        document.getElementById('f_imageUrl').value   = document.getElementById('imageUrlInput').value;
        document.getElementById('f_categoryId').value = document.getElementById('categorySelect').value;
        document.getElementById('f_action').value     = action;
        document.getElementById('articleForm').submit();
    }

    // ── Image preview (sidebar) ───────────────────────────────────────────────
    function toDisplayUrl(url) {
        var u = (url || '').trim();
        if (u === '') return '';
        if (/^https?:\/\//i.test(u)) return u;
        if (u.indexOf('${pageContext.request.contextPath}/') === 0) return u;
        if (u.charAt(0) === '/') return '${pageContext.request.contextPath}' + u;
        return '${pageContext.request.contextPath}/' + u;
    }

    function handleImgPreview(url) {
        var box = document.getElementById('imgPreviewBox');
        var img = document.getElementById('imgPreviewEl');
        var u = (url || '').trim();
        if (u !== '') {
            img.src = toDisplayUrl(u);
            box.classList.remove('hidden');
            img.onerror = function() { box.classList.add('hidden'); };
        } else {
            box.classList.add('hidden');
        }
    }

    // ── Preview modal ─────────────────────────────────────────────────────────
    function openPreview() {
        var title   = document.getElementById('titleInput').value || '(Chưa có tiêu đề)';
        var content = (tinymce && tinymce.get('contentEditor'))
            ? tinymce.get('contentEditor').getContent()
            : '';
        var imgUrl  = document.getElementById('imageUrlInput').value;

        document.getElementById('previewTitle').textContent = title;
        document.getElementById('previewBody').innerHTML    = content || '<p style="color:#475569">Chưa có nội dung.</p>';

        var hero    = document.getElementById('previewHero');
        var heroImg = document.getElementById('previewHeroImg');
        if (imgUrl && imgUrl.trim() !== '') {
            heroImg.src = toDisplayUrl(imgUrl);
            hero.classList.remove('hidden');
        } else {
            hero.classList.add('hidden');
        }
        document.getElementById('previewModal').classList.add('open');
        document.body.style.overflow = 'hidden';
    }

    function closePreview() {
        document.getElementById('previewModal').classList.remove('open');
        document.body.style.overflow = '';
    }

    // Đóng modal khi click ngoài
    document.getElementById('previewModal').addEventListener('click', function(e) {
        if (e.target === this) closePreview();
    });
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            if (document.getElementById('lightbox').classList.contains('open')) closeLightbox();
            else if (document.getElementById('previewModal').classList.contains('open')) closePreview();
            else if (focusMode) toggleFocusMode();
        }
    });

    // ── Theme ─────────────────────────────────────────────────────────────────
    // Wrap global toggleTheme to also update TinyMCE
    (function() {
        var baseToggle = window.toggleTheme;
        window.toggleTheme = function() {
            if (baseToggle) baseToggle();
            initTinyMCE(document.documentElement.classList.contains('dark'));
            
            // Also update the local iconTheme if it exists
            var iconTheme = document.getElementById('iconTheme');
            if (iconTheme) {
                iconTheme.textContent = document.documentElement.classList.contains('dark') ? 'light_mode' : 'dark_mode';
            }
        };
    })();

    // ── Focus mode ────────────────────────────────────────────────────────────
    var focusMode = false;
    var FLOAT_TOP_NORMAL = '250px';
    var FLOAT_TOP_FOCUS  = '200px';

    function toggleFocusMode() {
        focusMode = !focusMode;
        var sidebar  = document.getElementById('sidebarPanel');
        var hdr      = document.querySelector('header');
        var floatB   = document.getElementById('floatBtns');
        var iconFS   = document.getElementById('iconFullscreen');
        var dur      = 'all .3s ease';
        if (focusMode) {
            document.body.classList.add('focus-mode');
            sidebar.style.cssText = 'transition:' + dur + ';width:0;min-width:0;overflow:hidden;opacity:0';
            hdr.style.cssText     = 'transition:' + dur + ';height:0;overflow:hidden;opacity:0;padding:0';
            floatB.style.top      = FLOAT_TOP_FOCUS;
            iconFS.textContent    = 'fullscreen_exit';
        } else {
            document.body.classList.remove('focus-mode');
            sidebar.style.cssText = 'transition:' + dur;
            setTimeout(function(){ sidebar.style.cssText = ''; }, 320);
            hdr.style.cssText = 'transition:' + dur;
            setTimeout(function(){ hdr.style.cssText = ''; }, 320);
            floatB.style.top   = FLOAT_TOP_NORMAL;
            iconFS.textContent = 'fullscreen';
        }
    }

    function openLightbox(src) {
        document.getElementById('lightboxImg').src = src;
        document.getElementById('lightbox').classList.add('open');
        document.body.style.overflow = 'hidden';
    }
    function closeLightbox() {
        document.getElementById('lightbox').classList.remove('open');
        document.body.style.overflow = '';
    }

    // ── Image upload ──────────────────────────────────────────────────────────
    function uploadImage(input) {
        var file = input.files[0];
        if (!file) return;
        if (file.size > 10 * 1024 * 1024) { alert('Ảnh quá lớn! Tối đa 10MB.'); return; }
        var formData = new FormData();
        formData.append('image', file);
        var progress = document.getElementById('uploadProgress');
        var bar      = document.getElementById('uploadBar');
        var status   = document.getElementById('uploadStatus');
        bar.className = 'bg-indigo-500 h-1 rounded-full transition-all duration-300';
        progress.classList.remove('hidden');
        bar.style.width = '0%';
        status.textContent = 'Đang tải lên...';
        var pct = 0;
        var timer = setInterval(function() { pct = Math.min(pct + 12, 85); bar.style.width = pct + '%'; }, 80);
        fetch('${pageContext.request.contextPath}/api/upload', { method: 'POST', body: formData })
        .then(function(res) {
            // Server có thể trả HTML lỗi/redirect => tránh res.json() làm throw
            return res.text().then(function(t) {
                var data = null;
                try { data = JSON.parse(t); } catch (e) {}
                if (!res.ok) {
                    var msg = (data && data.message) ? data.message : (t || ('HTTP ' + res.status));
                    throw new Error(msg);
                }
                if (!data) throw new Error('Phản hồi không hợp lệ từ server');
                return data;
            });
        })
        .then(function(data) {
            clearInterval(timer);
            bar.style.width = '100%';
            if (data.success && data.url) {
                status.textContent = '✓ Tải lên thành công!' + (data.projectCopied ? '' : ' (đã lưu trên server)');
                // Lưu vào input dạng relative để tránh bị nhân đôi contextPath khi render nơi khác
                document.getElementById('imageUrlInput').value = data.url;
                handleImgPreview(data.url);
                if (!data.projectCopied && data.deployedDir) {
                    console.log('[Upload] saved to deployedDir:', data.deployedDir, 'projectDir:', data.projectDir);
                }
                setTimeout(function() { progress.classList.add('hidden'); }, 1800);
            } else {
                status.textContent = 'Lỗi: ' + (data.error || data.message || 'Không thể tải lên');
                bar.className = 'bg-red-500 h-1 rounded-full';
            }
        })
        .catch(function(err) {
            clearInterval(timer);
            status.textContent = 'Lỗi: ' + (err && err.message ? err.message : 'Không thể tải lên');
            bar.className = 'bg-red-500 h-1 rounded-full';
        });
        input.value = '';
    }

    function handleDrop(e) {
        e.preventDefault();
        document.getElementById('uploadZone').classList.remove('!border-indigo-500');
        var file = e.dataTransfer.files[0];
        if (file && file.type.startsWith('image/')) {
            var dt = new DataTransfer();
            dt.items.add(file);
            var inp = document.getElementById('fileInput');
            inp.files = dt.files;
            uploadImage(inp);
        }
    }

    function removeImage() {
        document.getElementById('imageUrlInput').value = '';
        document.getElementById('imgPreviewBox').classList.add('hidden');
        document.getElementById('imgPreviewEl').src = '';
    }
</script>

<%-- Notifications --%>
<div id="toast-container" class="fixed top-24 right-6 z-[10002] pointer-events-none space-y-3">
    <c:if test="${param.saved == 'true'}">
        <div id="toast-success" class="bg-emerald-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto animate-in fade-in slide-in-from-top-4 duration-500">
            <span class="material-symbols-outlined text-2xl">check_circle</span>
            <div>
                <p class="font-black tracking-tight text-sm">Thành công!</p>
                <p class="text-xs opacity-90">Bài viết đã được cập nhật thành công.</p>
            </div>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div id="toast-error" class="bg-red-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto animate-in fade-in slide-in-from-top-4 duration-500">
            <span class="material-symbols-outlined text-2xl">error</span>
            <div>
                <p class="font-black tracking-tight text-sm">Thất bại!</p>
                <p class="text-xs opacity-90">Có lỗi xảy ra: <c:out value="${param.error}" /></p>
            </div>
        </div>
    </c:if>
</div>

</body>
</html>
