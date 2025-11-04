<template>
  <div id="app">
    <h1 class="title">{{ title }}</h1>
    <Greeting />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import Greeting from './components/Greeting.vue'

const title = ref('Welcome to the Great Greeter App!')
</script>

<style>
#app {
  text-align: center;
  margin-top: 50px;
  font-family: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
  font-size: 1.75rem;
  gap: 0.6rem;
  align-items: baseline;
  margin-bottom: 1.25rem;
}
.title {
  color: #ff8000;
  font-weight: 700;
}
</style>
