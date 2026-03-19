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
    request: function(url, method, data) {
        if (data === undefined) data = null;
        
        const options = {
            method: method,
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            }
        };

        if (data && (method === 'POST' || method === 'PUT')) {
            options.body = JSON.stringify(data);
        }

        return fetch(url, options)
            .then(function(response) {
                const contentType = response.headers.get("content-type");
                let promise;
                
                if (contentType && contentType.indexOf("application/json") !== -1) {
                    promise = response.json();
                } else {
                    promise = response.text();
                }

                return promise.then(function(result) {
                    if (!response.ok) {
                        throw {
                            status: response.status,
                            message: result.message || 'Something went wrong',
                            data: result
                        };
                    }
                    return result;
                });
            })
            .catch(function(error) {
                console.error('AJAX Error:', error);
                throw error;
            });
    },

    /**
     * Shorthand for GET requests
     */
    get: function(url) { 
        return ajaxUtils.request(url, 'GET'); 
    },

    /**
     * Shorthand for POST requests
     */
    post: function(url, data) { 
        return ajaxUtils.request(url, 'POST', data); 
    },

    /**
     * Shorthand for PUT requests
     */
    put: function(url, data) { 
        return ajaxUtils.request(url, 'PUT', data); 
    },

    /**
     * Shorthand for DELETE requests
     */
    delete: function(url) { 
        return ajaxUtils.request(url, 'DELETE'); 
    }
};
