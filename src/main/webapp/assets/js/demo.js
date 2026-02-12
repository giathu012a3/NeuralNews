/**
 * demo.js
 * Logic for the AJAX Demo page.
 * Uses the Module pattern to keep the global namespace clean.
 */

const DemoApp = {
    contextPath: '',

    /**
     * Initialize the demo app
     * @param {string} ctxPath - Content path from JSP
     */
    init: function (ctxPath) {
        this.contextPath = ctxPath;
        this.bindEvents();
        console.log('DemoApp initialized with context path:', this.contextPath);
    },

    bindEvents: function () {
        const getBtn = document.getElementById('getBtn');
        const postBtn = document.getElementById('postBtn');

        if (getBtn) {
            getBtn.addEventListener('click', () => this.testGet());
        }

        if (postBtn) {
            postBtn.addEventListener('click', () => this.testPost());
        }
    },

    // Function to handle GET request demo
    testGet: function () {
        const resultDiv = document.getElementById('getResult');
        resultDiv.innerHTML = 'Loading...';

        // Using our global utility 'ajaxUtils'
        ajaxUtils.get(this.contextPath + '/api/test-ajax')
            .then(data => {
                resultDiv.innerHTML = '<strong>Success:</strong> <pre>' + JSON.stringify(data, null, 2) + '</pre>';
                console.log('GET Result:', data);
            })
            .catch(error => {
                resultDiv.innerHTML = '<span class="text-red-500">Error: ' + (error.message || 'Unknown error') + '</span>';
                console.error('GET Error:', error);
            });
    },

    // Function to handle POST request demo
    testPost: function () {
        const resultDiv = document.getElementById('postResult');
        resultDiv.innerHTML = 'Sending...';

        const payload = {
            name: "User Test",
            action: "demo",
            timestamp: new Date().toISOString()
        };

        // Using our global utility 'ajaxUtils'
        ajaxUtils.post(this.contextPath + '/api/test-ajax', payload)
            .then(data => {
                resultDiv.innerHTML = '<strong>Success:</strong> <pre>' + JSON.stringify(data, null, 2) + '</pre>';
                console.log('POST Result:', data);
            })
            .catch(error => {
                resultDiv.innerHTML = '<span class="text-red-500">Error: ' + (error.message || 'Unknown error') + '</span>';
                console.error('POST Error:', error);
            });
    }
};
