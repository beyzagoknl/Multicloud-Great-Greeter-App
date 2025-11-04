import { createApp } from 'vue'
import App from './App.vue'
import PrimeVue from 'primevue/config'
import Card from 'primevue/card'
import Button from 'primevue/button'

// PrimeVue styles
import 'primevue/resources/themes/saga-blue/theme.css'   // choose a theme
import 'primevue/resources/primevue.min.css'
import 'primeicons/primeicons.css'
import 'primeflex/primeflex.css' // optional layout utilities

const app = createApp(App)
app.use(PrimeVue)
app.component('Card', Card)
app.component('Button', Button)
app.mount('#app')