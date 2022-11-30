# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin '@rails/ujs', to: 'https://ga.jspm.io/npm:@rails/ujs@7.0.3-1/lib/assets/compiled/rails-ujs.js'
pin 'chart.js', to: 'https://ga.jspm.io/npm:chart.js@4.0.1/dist/chart.js'
pin_all_from 'app/javascript/custom', under: 'custom'
pin 'datepicker.js', to: 'https://unpkg.com/flowbite@1.5.4/dist/datepicker.js'
