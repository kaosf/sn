self.addEventListener("push", (e) => {
  const { title, body, url } = e.data.json();
  self.registration.showNotification(title, { body, data: { url } });
});
self.addEventListener("notificationclick", (e) => {
  if (clients.openWindow) {
    e.notification.close();
    e.waitUntil(clients.openWindow(e.notification.data.url));
  }
});
