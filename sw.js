const CACHE = 'walkpod-v3';
const SHELL = [
  './', './index.html', './manifest.webmanifest', './icon.svg'
];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(SHELL)).catch(() => { }));
  self.skipWaiting();
});

self.addEventListener('activate', e => {
  e.waitUntil(caches.keys()
    .then(ks => Promise.all(ks.filter(k => k !== CACHE && k !== 'walkpod-audio').map(k => caches.delete(k)))));
  self.clients.claim();
});

self.addEventListener('fetch', e => {
  const req = e.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);
  if (url.origin !== self.location.origin) return;
  // 音频交给页面用 Cache API 自行管理（兼容 Range 请求）
  if (url.pathname.endsWith('.mp3')) return;

  e.respondWith(
    fetch(req).then(r => {
      if (r.ok) {
        const cp = r.clone();
        caches.open(CACHE).then(c => c.put(req, cp)).catch(() => { });
      }
      return r;
    }).catch(() => caches.match(req).then(m => m || caches.match('./index.html')))
  );
});
