document.addEventListener('DOMContentLoaded', function() {
	const searchInput = document.getElementById('searchInput');
	const baseUrl = document.getElementById('baseUrl').value;
	
	function performSearch() {
		const searchTerm = searchInput.value;
		if (searchTerm.trim() !== '') {
			const searchUrl = `https://www.google.com/search?q=${encodeURIComponent(searchTerm)}+site:${baseUrl}`;
			window.open(searchUrl, '_blank');
		}
	}

	// Event listener for the Enter key
	searchInput.addEventListener('keypress', function(event) {
		if (event.key === 'Enter') {
			event.preventDefault();
			performSearch();
		}
	});
});