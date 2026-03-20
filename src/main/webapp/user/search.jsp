<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html class="dark" lang="vi">
<head>
    <title>Kết quả tìm kiếm cho: ${keyword} | NexusAI</title>
    <jsp:include page="components/head.jsp" />
</head>

<body class="bg-background-light dark:bg-background-dark text-text-main dark:text-white font-display antialiased overflow-x-hidden transition-colors duration-200">
    <div class="flex min-h-screen w-full flex-col">
        <jsp:include page="components/header.jsp" />

        <main class="flex-1 w-full max-w-[1440px] mx-auto p-4 lg:p-8">
            <div class="mb-8">
                <nav class="flex items-center gap-2 text-sm text-slate-500 mb-4">
                    <a href="${pageContext.request.contextPath}/home" class="hover:text-primary transition-colors">Trang chủ</a>
                    <span class="material-symbols-outlined text-[16px]">chevron_right</span>
                    <span class="text-slate-900 dark:text-white font-medium">Tìm kiếm</span>
                </nav>

                <h1 class="text-3xl font-extrabold text-slate-900 dark:text-white flex items-center gap-3">
                    <span class="material-symbols-outlined text-[32px] text-primary">search</span>
                    Kết quả tìm kiếm cho: <span class="italic text-primary">"${keyword}"</span>
                </h1>
                
                <c:if test="${not empty articles}">
                    <p class="mt-2 text-sm text-slate-500">Tìm thấy <strong>${articles.size()}</strong> bài báo phù hợp với từ khóa của bạn.</p>
                </c:if>
            </div>

            <c:choose>
                <c:when test="${empty articles}">
                    <div class="flex flex-col items-center justify-center py-20 text-center">
                        <div class="size-24 rounded-full bg-slate-100 dark:bg-slate-800 flex items-center justify-center mb-6">
                            <span class="material-symbols-outlined text-[48px] text-slate-400">search_off</span>
                        </div>
                        <h2 class="text-2xl font-bold text-slate-900 dark:text-white mb-2">Không tìm thấy kết quả nào</h2>
                        <p class="text-slate-500 max-w-md mx-auto">Chúng tôi không tìm thấy bài báo nào khớp với từ khóa <strong>"${keyword}"</strong>. Vui lòng thử lại với từ khóa khác hoặc kiểm tra lại chính tả.</p>
                        <a href="${pageContext.request.contextPath}/home" class="mt-8 px-6 py-2.5 bg-primary text-white rounded-full font-bold hover:bg-primary-dark transition-colors shadow-lg shadow-primary/25">
                            Quay lại trang chủ
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                        <c:forEach var="a" items="${articles}">
                            <article onclick="window.location.href='${pageContext.request.contextPath}/user/article?id=${a.id}'"
                                class="bg-white dark:bg-surface-dark rounded-xl overflow-hidden shadow-sm hover:shadow-xl transition-all duration-300 cursor-pointer group flex flex-col h-full border border-slate-100 dark:border-slate-800">
                                <div class="relative h-48 w-full overflow-hidden">
                                    <div class="absolute inset-0 bg-cover bg-center transition-transform duration-500 group-hover:scale-110"
                                         style="background-image: url('${not empty a.imageUrl ? (a.imageUrl.startsWith('http') ? a.imageUrl : pageContext.request.contextPath.concat('/').concat(a.imageUrl)) : pageContext.request.contextPath.concat('/assets/images/placeholder.jpg')}');">
                                    </div>
                                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
                                    <div class="absolute bottom-3 left-3">
                                        <span class="px-2 py-0.5 rounded bg-primary text-white text-[10px] font-bold uppercase tracking-wider">
                                            ${not empty a.categoryName ? a.categoryName : 'Tin tức'}
                                        </span>
                                    </div>
                                </div>
                                <div class="p-4 flex flex-col flex-1">
                                    <h3 class="text-lg font-bold text-slate-900 dark:text-white leading-tight mb-2 group-hover:text-primary transition-colors line-clamp-2">
                                        ${a.title}
                                    </h3>
                                    <p class="text-slate-500 dark:text-slate-400 text-xs line-clamp-3 mb-4">
                                        ${a.summary}
                                    </p>
                                    <div class="mt-auto flex items-center justify-between pt-4 border-t border-slate-50 dark:border-slate-800">
                                        <div class="flex items-center gap-1.5 text-[10px] text-slate-400 uppercase font-bold tracking-tight">
                                            <span class="material-symbols-outlined text-[14px]">calendar_today</span>
                                            <fmt:formatDate value="${a.publishedAt}" pattern="dd/MM/yyyy" />
                                        </div>
                                        <span class="text-primary material-symbols-outlined text-[18px] opacity-0 group-hover:opacity-100 transition-all transform translate-x-2 group-hover:translate-x-0">arrow_forward</span>
                                    </div>
                                </div>
                            </article>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>

        <jsp:include page="components/footer.jsp" />
    </div>
</body>
</html>
