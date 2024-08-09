'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"assets/FontManifest.json": "893a789e8ac4266f147096e20081e8a1",
"assets/AssetManifest.bin.json": "e97efc7c71fcdaab149959ecfee06021",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/assets/icons/logo.png": "20c8fb124314f5a088a1a78497486850",
"assets/assets/icons/social_logos.png": "e8bbf369e6bd0f8a55234b7d3e976772",
"assets/assets/fonts/Lato-BoldItalic.ttf": "f98d18040a766b7bc4884b8fcc154550",
"assets/assets/fonts/Lato-BlackItalic.ttf": "2e26a9163cb4974dcba1bea5107d4492",
"assets/assets/fonts/Lato-LightItalic.ttf": "4d80ac573c53d192dafd99fdd6aa01e9",
"assets/assets/fonts/NotoColorEmoji_Windows.ttf": "1260698c9167fd32cbfd58a01b6b9747",
"assets/assets/fonts/Lato-Light.ttf": "2fe27d9d10cdfccb1baef28a45d5ba90",
"assets/assets/fonts/Lato-Regular.ttf": "2d36b1a925432bae7f3c53a340868c6e",
"assets/assets/fonts/Lato-ThinItalic.ttf": "4ac7208bbe0e3593ce9464f013607751",
"assets/assets/fonts/ZenKakuGothicAntique-Black.ttf": "c4aaab7b04dc435f43061d9797776d1c",
"assets/assets/fonts/ZenAntiqueSoft-Regular.ttf": "6a9f1cc793526c3c4d9972e3ce425880",
"assets/assets/fonts/Lato-Italic.ttf": "7582e823ef0d702969ea0cce9afb326d",
"assets/assets/fonts/Lato-Thin.ttf": "9a77fbaa85fa42b73e3b96399daf49c5",
"assets/assets/fonts/ZenKakuGothicAntique-Bold.ttf": "fd7236a5ce33da16f2feda5156d9b21f",
"assets/assets/fonts/Lato-Bold.ttf": "85d339d916479f729938d2911b85bf1f",
"assets/assets/fonts/Lato-Black.ttf": "e631d2735799aa943d93d301abf423d2",
"assets/assets/images/car_lineup/car_model_8.webp": "b2dae41330a405062efe48d294656818",
"assets/assets/images/car_lineup/car_model_7.webp": "38d4d5b6c30bf1a48075b5606638341d",
"assets/assets/images/car_lineup/car_lineup_bg_1.jpg": "cb49f692179f93c98eb5fdea5a324217",
"assets/assets/images/car_lineup/car_model_17.webp": "b070f6bb2765f5c52d00393c811cf95b",
"assets/assets/images/car_lineup/car_model_4.webp": "ef8aa1905617be7ec5d5421b0dfd1a67",
"assets/assets/images/car_lineup/car_model_15.webp": "cb239bdcf96f4550bbe297fe025dccb3",
"assets/assets/images/car_lineup/car_model_19.webp": "4e39c589d6d9094a8a34fd786f13db29",
"assets/assets/images/car_lineup/car_model_2.webp": "799556171d1e20ab52c0a3ee988edda8",
"assets/assets/images/car_lineup/car_lineup_bg_2.jpg": "5d69666babdf2d9d092cba7387c56cc9",
"assets/assets/images/car_lineup/car_model_20.webp": "c3f6546fbc362de133470ec8626fab03",
"assets/assets/images/car_lineup/car_lineup_bg_7.jpg": "b4a4988d979392382efd9ae455ceecea",
"assets/assets/images/car_lineup/car_lineup_bg_6.jpg": "ab072a3d37734f991750a30c5223f0aa",
"assets/assets/images/car_lineup/car_model_5.webp": "83c1a5843e1bd7ac1ad39830b4ed9a41",
"assets/assets/images/car_lineup/car_model_16.webp": "4232115552568a70ecc7d6ab47b01870",
"assets/assets/images/car_lineup/car_lineup_bg_4.jpg": "6e467fa537833e95438c56a6827bc156",
"assets/assets/images/car_lineup/car_model_11.webp": "bf3e2deab28f62a851e2bfeb8d9d15c8",
"assets/assets/images/car_lineup/car_lineup_bg_3.jpg": "4066e67052c4c8a99e1083fc94c7c7bb",
"assets/assets/images/car_lineup/car_model_18.webp": "5739f46bf956ade56467f1bc77ed527a",
"assets/assets/images/car_lineup/car_model_3.webp": "6ef6db97756b4fa490805022588c2b79",
"assets/assets/images/car_lineup/car_lineup_bg_5.jpg": "a59dd4d5915b42f3be0a2a1c7b7eb1fc",
"assets/assets/images/car_lineup/car_model_14.webp": "cd16813b711d08971dda93b8e95a8c23",
"assets/assets/images/car_lineup/car_model_12.webp": "f9a161c026ab7afb780f76f903e76a7c",
"assets/assets/images/car_lineup/car_model_9.webp": "6900a61061b1e11f35da4bee5e241b76",
"assets/assets/images/car_lineup/car_model_1.webp": "0e4f25852281f6ee6af64285aa09a9ac",
"assets/assets/images/car_lineup/car_model_21.webp": "89361f4d1269278dd9ebd0ca662e2887",
"assets/assets/images/car_lineup/car_model_13.webp": "dc47efa4fbacb24d3c9ebfd4bbc9501f",
"assets/assets/images/car_lineup/car_model_6.webp": "a951a0ff4bbef10202c68cc4ea1e82bc",
"assets/assets/images/car_lineup/car_model_22.webp": "f8c188fcc5260655b5b9f5902ae2cdc4",
"assets/assets/images/car_lineup/car_model_10.webp": "09f410ae1fe0a6f55e7ca26405c9c98e",
"assets/assets/images/car_highlights/car_3_prev_2.jpg": "3c10ac5133d1cb34f2903126212a5e38",
"assets/assets/images/car_highlights/car_3.jpg": "ccd1e299228d3a0b63929d05620b0ed9",
"assets/assets/images/car_highlights/car_1.jpg": "3f399a74e0f275cb3a8ec6e6bd06c68c",
"assets/assets/images/car_highlights/car_3_prev_1.jpg": "8ca1eabf44c344fc16bc0bfb4138c1b6",
"assets/assets/images/car_highlights/car_1_prev_2.jpg": "62c133a03f51a9d437cd43ea3d9bab44",
"assets/assets/images/car_highlights/car_2.jpg": "369f66b4c149249a090878ef1d9dbec7",
"assets/assets/images/car_highlights/car_1_prev_1.jpg": "a3c6d7a50d5fc636ecd5ceba56d90b86",
"assets/assets/images/car_highlights/car_2_prev_2.jpg": "c4af3e34d0fcfc5092f0deed28c51806",
"assets/assets/images/car_highlights/car_2_prev_1.jpg": "4063f71e583a6a6c6594f392f6832bba",
"assets/assets/images/news/news_1.webp": "7fe2ae0f2eecb3b88d279690bae43412",
"assets/assets/images/news/news_2.webp": "381cfb835eafaa4a09d4e38e1c985ff4",
"assets/assets/images/news/news_5.webp": "b79d47095b12c82012cbfa1724ab545c",
"assets/assets/images/news/news_3.webp": "599a453248e93f3618a8b16071d6ee7d",
"assets/assets/images/news/news_4.webp": "da153477bd78a755f62da722d59b50ea",
"assets/fonts/MaterialIcons-Regular.otf": "26fd46ee823525396b14671d980117d4",
"assets/AssetManifest.bin": "814c562a0009d86f18fd964937cbd084",
"assets/AssetManifest.json": "9b6e9816ca49e2b072cdf91d21b19517",
"assets/NOTICES": "f860afde95bfc56be1db176fa5736a9d",
"index.html": "1c6a9fc2b03889890404c122770d01ff",
"/": "1c6a9fc2b03889890404c122770d01ff",
"main.dart.js": "2f4a5ede65b817a57eb51660acef0c05",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"version.json": "0cc090cb1a861e99be7f54583720ed7b",
"flutter_bootstrap.js": "f70e26e5ad7f2bec0a09f22037d936c4",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "87325e67bf77a9b483250e1fb1b54677",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.js": "5fda3f1af7d6433d53b24083e2219fa0",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "9fa2ffe90a40d062dd2343c7b84caf01",
"manifest.json": "3bd02f1a7175bacbb3dcf7296a3a9a09",
"flutter.js": "f31737fb005cd3a3c6bd9355efd33061"};
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
