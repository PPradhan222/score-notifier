self.addEventListener('install', event => {
  console.log('Service worker installing................');
  self.skipWaiting();  
});

self.addEventListener('activate', event => {
  console.log('Service worker activating....................');
});

self.addEventListener("push", (event) => {
  console.log("push received!!!!!!!!")
  let body = (event.data && event.data.text()) || "Yay a message";
  let title = "Score Notifier";

  event.waitUntil(
    self.registration.showNotification(title, {body})
  )
});