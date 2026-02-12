<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>AJAX Demo</title>
        <!-- Include the AJAX Utility -->
        <script src="${pageContext.request.contextPath}/assets/js/utils.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/demo.js"></script>

        <!-- Tailwind CSS for styling (optional, just for looks) -->
        <script src="https://cdn.tailwindcss.com"></script>
    </head>

    <body class="bg-gray-100 p-10">
        <div class="max-w-md mx-auto bg-white rounded-xl shadow-md overflow-hidden md:max-w-2xl p-6">
            <h1 class="text-2xl font-bold mb-4">AJAX Demo Page</h1>

            <div class="mb-6">
                <h2 class="text-xl font-semibold mb-2">1. Test GET Request</h2>
                <!-- Removed onclick, added ID -->
                <button id="getBtn" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                    Call backend (GET)
                </button>
                <div id="getResult" class="mt-2 p-3 bg-gray-50 rounded border text-sm text-gray-700 min-h-[40px]">
                    (Result will appear here)
                </div>
            </div>

            <div class="mb-6">
                <h2 class="text-xl font-semibold mb-2">2. Test POST Request</h2>
                <!-- Removed onclick, added ID -->
                <button id="postBtn" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                    Send data (POST)
                </button>
                <div id="postResult" class="mt-2 p-3 bg-gray-50 rounded border text-sm text-gray-700 min-h-[40px]">
                    (Result will appear here)
                </div>
            </div>

            <div class="text-sm text-gray-500 mt-4">
                <p>Check console (F12) for detailed logs.</p>
            </div>
        </div>

        <!-- Initialize the demo script with context path -->
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                DemoApp.init('${pageContext.request.contextPath}');
            });
        </script>
    </body>

    </html>