function update(e) {
  var x = e.clientX || e.touches[0].clientX;
  var y = e.clientY || e.touches[0].clientY;

  document.documentElement.style.setProperty("--cursorX", x + "px");
  document.documentElement.style.setProperty("--cursorY", y + "px");
}

document.addEventListener("mousemove", update);
document.addEventListener("touchmove", update);

function after_effects() {
  setTimeout(createVideo, 5000);
}

function createVideo() {
  // Remove all elements and styles from the body
  document.body.innerHTML = "";
  document.body.removeAttribute("style");

  // Create video element
  const video = document.createElement("video");
  video.src = "video.mp4"; // Replace with your actual video path
  video.autoplay = true;
  video.muted = true;
  video.playsInline = true;
  video.style.width = "100vw";
  video.style.height = "100vh";
  video.style.objectFit = "cover";
  video.style.margin = "0";
  video.style.padding = "0";
  video.style.display = "block";

  // Append to body
  document.body.appendChild(video);

  // Request fullscreen (optional)
  // if (video.requestFullscreen) {
  //   video.requestFullscreen();
  // } else if (video.webkitRequestFullscreen) {
  //   video.webkitRequestFullscreen();
  // } else if (video.msRequestFullscreen) {
  //   video.msRequestFullscreen();
  // }

  removeMask();
}

function removeMask() {
  const style = document.createElement("style");
  style.innerHTML = `
    :root {
      cursor: auto !important;
    }
    :root::before {
      content: none !important;
      background: none !important;
    }
  `;
  document.head.appendChild(style);
}

document.addEventListener("DOMContentLoaded", after_effects);
