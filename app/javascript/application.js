// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import Rails from '@rails/ujs';

Rails.start();


document.addEventListener('turbo:load', ()=>{

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
    });
    document.addEventListener('ajax:complete', () => {
        // Toggle visibility of icons back to normal
        searchIcon.style.display = 'inline-block';
        loadingSpinner.style.display = 'none';
    
        // Re-enable the button
        button.removeAttribute('disabled');
      });
    
})



