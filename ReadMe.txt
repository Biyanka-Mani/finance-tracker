document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('search_stocks_form');
    const button = document.getElementById('search_button');
    const searchIcon = document.getElementById('search_icon');
    const loadingSpinner = document.getElementById('loading_spinner');
  
    form.addEventListener('submit', (event) => {
      // Prevent default form submission behavior
      event.preventDefault();
  
      // Toggle visibility of icons
      searchIcon.style.display = 'none';
      loadingSpinner.style.display = 'inline-block';
  
      // Optionally, you can also disable the button to prevent multiple submissions
      button.setAttribute('disabled', 'disabled');
  
      // Use Rails UJS to handle the remote form submission
      Rails.fire(form, 'submit');
    });
  
    // Listen for the Ajax request to complete and reset the button
    document.addEventListener('ajax:complete', () => {
      // Toggle visibility of icons back to normal
      searchIcon.style.display = 'inline-block';
      loadingSpinner.style.display = 'none';
  
      // Re-enable the button
      button.removeAttribute('disabled');
    });
  });
  
