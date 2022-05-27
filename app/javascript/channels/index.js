// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const ConcatenatedModule = require("webpack/lib/optimize/ConcatenatedModule");

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

console.log("HELLO FROM THE CONSOLE")

document.addEventListener('turbolinks:load', () => {

  const meme_generator = document.getElementById('meme-generator')
  const text_container = document.getElementById("text-container")
  const memes = document.querySelectorAll(".img-class")
  const meme_url = document.getElementById("meme-url")

  memes.forEach((meme) => {
    meme.addEventListener("click", () => {
      console.log(meme_generator)
      text_container.classList.remove("d-none")
      meme_url.value = meme.src
      meme_generator.style.backgroundImage = `url(${meme.src})`
    })
  })

  const text_meme1 = document.getElementById("text-meme1")
  const text_meme2 = document.getElementById("text-meme2")
  const fiel_text1 = document.querySelector("#text-imagen1")
  const fiel_text2 = document.querySelector("#text-imagen2")


  text_meme1.addEventListener("keyup",(event) => {
    fiel_text1.innerHTML = text_meme1.value
  })


  text_meme2.addEventListener("keyup", (event) => {
    fiel_text2.innerHTML = text_meme2.value
  })
});
