'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "7569eadf679ee7cfbf58ab1e5ace6099",
"version.json": "7c09e7291f971a0f7fa32a29c5055e99",
"index.html": "4af00e02d062c172bac9ee8b626590f7",
"/": "4af00e02d062c172bac9ee8b626590f7",
"main.dart.js": "bf36e05364ce2c2e753511c5e2c70399",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "3f8f612479cc17a43d4cb30552c30079",
"icons/Icon-192.png": "18c5eb0aa1a02e4a59d1772ee05b608a",
"icons/Icon-maskable-192.png": "18c5eb0aa1a02e4a59d1772ee05b608a",
"icons/Icon-maskable-512.png": "545ad845b578667b79fac4b8768bcd66",
"icons/Icon-512.png": "545ad845b578667b79fac4b8768bcd66",
"manifest.json": "ac1117c30de9989c945de2b976d8d664",
"assets/AssetManifest.json": "c17a5b21a2c7d4467b9aa52bbf9784f7",
"assets/NOTICES": "c09de64d3708439f29770fa6709c7154",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "3ce30c3e93533bcecdce5bacd9d33a9f",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "48944a333b321269d399734e096d34a0",
"assets/fonts/MaterialIcons-Regular.otf": "0ce89296dfebcedb7366ae7a0f18cc71",
"assets/assets/images/entertainment_dark.png": "b8e132cb171b24c63a781cff998e07f4",
"assets/assets/images/science.png": "bdae82bfde7e3e144576a4a1c57935c7",
"assets/assets/images/busniess_dark.png": "e6d483f60331edfbd910058119d50bc9",
"assets/assets/images/Group%25201.png": "feb425e4cf41269329c0e4873ab459c1",
"assets/assets/images/entertainment.png": "d8a78ddfa8c367d5905c26491da80a60",
"assets/assets/images/sport.png": "2c2950b6a3b09d53ae669f4d0db32dee",
"assets/assets/images/technology.png": "b62abe6fa890094942349e92e993669d",
"assets/assets/images/helth.png": "3f30f20bc0b9efb74a2934f03ea51d50",
"assets/assets/images/General_dark.png": "8c6626d71defbd31c7337305e028d774",
"assets/assets/images/sports_dark.png": "99b174d9661b15e176178f97c199f7ae",
"assets/assets/images/health_dark.png": "3c6597677a6db79a3d3edf5bd0ff1924",
"assets/assets/images/Rectangle%25202.png": "f636d989540fb69011f2837662b40c04",
"assets/assets/images/tech_dark.png": "d766111ce8e3d90bdfada6961572c253",
"assets/assets/images/General.png": "6d64da3656cc74f7102c7f7ac306d200",
"assets/assets/images/busniess.png": "f18340dab58d9133cc7438611f5221c3",
"assets/assets/images/science_dark.png": "9814ff8933d0ef33411ac42007d6ef61",
"assets/assets/splashscreens/splash_dark.png": "ad71ff77d5213b6391df9ad3c1a59a65",
"assets/assets/splashscreens/technology.png": "b62abe6fa890094942349e92e993669d",
"assets/assets/splashscreens/splash_light.png": "1a1c20c42d7ece4393daadeea98602e0",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
