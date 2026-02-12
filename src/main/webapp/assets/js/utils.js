/**
 * Global AJAX Utility for NeuralNews
 * Wraps the Fetch API to provide a simple interface for GET, POST, PUT, DELETE requests.
 */
const ajaxUtils = {
    /**
     * Generic request handler
     * @param {string} url - The endpoint URL
     * @param {string} method - HTTP method (GET, POST, PUT, DELETE)
     * @param {object} data - Data to send (for POST, PUT)
     * @returns {Promise} - Resolves with JSON response or rejects with error
     */
    request: async (url, method, data = null) => {
        const options = {
            method: method,
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest' // Helper for backend to detect AJAX
            }
        };

        if (data && (method === 'POST' || method === 'PUT')) {
            options.body = JSON.stringify(data);
        }

        try {
            const response = await fetch(url, options);

            // Check if response is JSON
            const contentType = response.headers.get("content-type");
            let result;
            if (contentType && contentType.indexOf("application/json") !== -1) {
                result = await response.json();
            } else {
                result = await response.text();
            }

            if (!response.ok) {
                throw {
                    status: response.status,
                    message: result.message || 'Something went wrong',
                    data: result
                };
            }

            return result;
        } catch (error) {
            console.error('AJAX Error:', error);
            throw error;
        }
    },

    /**
     * Shorthand for GET requests
     * @param {string} url 
     */
    get: (url) => ajaxUtils.request(url, 'GET'),

    /**
     * Shorthand for POST requests
     * @param {string} url 
     * @param {object} data 
     */
    post: (url, data) => ajaxUtils.request(url, 'POST', data),

    /**
     * Shorthand for PUT requests
     * @param {string} url 
     * @param {object} data 
     */
    put: (url, data) => ajaxUtils.request(url, 'PUT', data),

    /**
     * Shorthand for DELETE requests
     * @param {string} url 
     */
    delete: (url) => ajaxUtils.request(url, 'DELETE')
};
