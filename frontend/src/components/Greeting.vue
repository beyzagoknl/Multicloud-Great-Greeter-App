<template>
  <div class="wrapper">
    <Card class="greeting-card" :title="title">
      <template #content>
        <div class="card-content">
          <transition name="fade">
            <template v-if="loading">
              <p key="loading" class="loading">
                <i class="pi pi-spin pi-spinner icon" /> Loading...
              </p>
            </template>
            <template v-else-if="error">
              <p key="error" class="error">
                <i class="pi pi-exclamation-triangle icon" /> {{ error }}
              </p>
            </template>
            <template v-else>
              <p key="greeting" class="greeting">
                <i class="pi pi-smile icon" /> {{ greeting }}
              </p>
            </template>
          </transition>

          <Button
            label="Refresh"
            icon="pi pi-refresh"
            class="refresh-button p-button-outlined"
            @click="getGreeting"
            :loading="loading"
            :aria-disabled="loading"
          />
        </div>
      </template>
    </Card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { fetchGreeting } from '../services/api'

const title = 'Great Greeter'
const greeting = ref('')
const error = ref(null)
const loading = ref(false)

const getGreeting = async () => {
  loading.value = true
  error.value = null
  try {
    const res = await fetchGreeting()
    greeting.value = typeof res.data === 'string' ? res.data.trim() : JSON.stringify(res.data)
  } catch (err) {
    console.error('Error fetching greeting:', err)
    error.value = 'Failed to load greeting'
    greeting.value = ''
  } finally {
    loading.value = false
  }
}

onMounted(getGreeting)
</script>

<style scoped>
.wrapper {
  display: flex;
  justify-content: center;
  margin-top: 60px;
}

.greeting-card {
  min-width: 30rem;
  border-radius: 12px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
  overflow: hidden;
  border: 2px solid #ff8000;
}

.card-content {
  text-align: center;
  padding: 24px;
}

/* Greeting message */
.greeting {
  color: #ff8000; /* Takeaway orange */
  font-size: 1.5rem;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 24px;
}

/* Error message */
.error {
  color: #cc3300; /* darker red-orange for error */
  font-size: 1.1rem;
  font-weight: 500;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 24px;
}

/* Loading state */
.loading {
  color: #666;
  font-size: 1.1rem;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 24px;
}

/* Shared icon spacing */
.icon {
  margin-right: 0.5rem;
  font-size: 1.2rem;
}

/* Branded refresh button */
.refresh-button {
  margin-top: 8px;
  border-color: #ff8000;
  color: #ff8000;
}

.refresh-button:hover {
  background-color: #ff8000;
  color: #fff;
}

/* Fade animation */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>