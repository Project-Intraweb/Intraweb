<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Project Intraweb</title>
    <style>
    html, body {
      font-family: 'Roboto', sans-serif;
      margin: 0;
      padding: 0;
      padding-bottom: 15px;
      background: #F2F3F7;
    }
    :root {
      --primary-color: #0099ff;
      --font-color: black;
      --bg-color: white;
      --shadow-color: rgba(0,0,0,0.2);
    }
    a {
      text-decoration: none;
      color:inherit;
    }
    .cont{
      height: auto;
      width: 100%;
      max-width: 1100px;
      margin-left: auto;
      margin-right: auto;
      position:relative;
    }
    h1 {
      position: relative;
      color: var(--font-color);
      margin: 0;
      font-size: 35px;
      margin-top: 30px;
      margin-left: 10px;
      margin-bottom: 30px;
      font-weight: 900px;
    }
    .logo {
      background: red;
      height: 75px;
      width: 75px;
      margin-top: 10px;
      margin-bottom: 10px;
      margin-left: 10px;
      border-radius: 15px;
      background-size: cover;
      background-position: center;
      display: inline-block;
    }
    h3 {
      position: relative;
      color: var(--font-color);
      font-size: 20px;
      text-transform: uppercase;
      display: inline-block;
      margin-left: 5px;
    }
    h4 {
      position: relative;
      color: var(--font-color);
      margin: 0;
      display: inline-block;
      font-size: 20px;
      padding-left: 10px;
      padding-bottom: 30px;
      font-weight: 900px;
    }
    .card {
      width: calc(92.5vw);
      height: auto;
      background: var(--bg-color);
      contain: content;
      max-width: 1000px;
      margin-left: auto;
      margin-right: auto;
      box-shadow: 0 10px 16px 0 var(--shadow-color);
      transition: 0.25s;
      border-radius: 20px;
      margin-bottom: 25px;
      display: block;
    }
    .banner {
      width: calc(92.5vw);
      height: 75vh;
      background-size: cover;
      background-position: bottom;
      contain: content;
      max-width: 1000px;
      margin-left: auto;
      margin-right: auto;
      transition: 0.25s;
      border-radius: 20px;
      margin-bottom: 25px;
      margin-top: 25px;
      display: flex;
    }
    .banner .text {
      align-self: flex-end;
      color: white;
    }

    .card:hover{
      transform: scale(1.025);
      box-shadow: 0 20px 40px 0 var(--shadow-color);
    }
    .card:active{
      transform: scale(.975);
      box-shadow: 0 20px 40px 0 var(--shadow-color);
    }
    .divider {
      display: inline-block;
      height: 20px;
      width: 3px;
      position: relative;
      border-radius: 30px;
      background: #0099ff;
      margin-left: 35px;
    }
    p {
      margin-left: 25px;
      margin-right: 7.5px;
      margin-bottom: 20px;
      color: var(--font-color);
    }
    .container {
      display: flex;
      width: calc(92.5vw);
      margin-left: auto;
      justify-content: space-between;
      margin-right: auto;
      flex-flow: row wrap;
      max-width: 1000px;
    }
    .flexcard h1 {
      display: inline-block;
      vertical-align:top
    }
    .flexcard {
      height: auto;
      background: var(--bg-color);
      contain: content;
      max-width: 450px;
      margin-left: auto;
      margin-right: auto;
      box-shadow: 0 10px 16px 0 var(--shadow-color);
      transition: 0.25s;
      border-radius: 20px;
      margin-bottom: 25px;
      flex: 50%;
    }
    @media (max-width: 1000px) {
      .container {
        flex-direction: column;
      }
      .flexcard {
        width: calc(92.5vw);
        max-width: 1000px;
      }
    }
    .flexcard:hover{
      transform: scale(1.025);
      box-shadow: 0 20px 40px 0 var(--shadow-color);
    }
    .flexcard:active{
      transform: scale(.975);
      box-shadow: 0 20px 40px 0 var(--shadow-color);
    }
    </style>
  </head>
  <body>
    <div class="cont">
      <div class="banner" id="banner">
        <div class="text">
          <h1 id="greeting" style="color: white; margin-bottom: 0px;"></h1>
          <p id="description" style="margin-top: 10px; color: white; margin-left: 10px;"></p>
        </div>
      </div>
      <a class="card" style="background: #0099ff;" href="#">
        <h1 style="color: white;">Project Intraweb</h1>
        <h4 style="color: white;">Current Internet Status:</h4>
        <h4 id="status" style="color: white; padding-left: 0px;">Loading</h4>
      </a>
    <div class="divider">
    </div>
    <h3>APPS</h3>
    <div class="container">
      <?php
      ini_set('display_errors', 1);
      ini_set('display_startup_errors', 1);
  error_reporting(E_ALL);
      $json = file_get_contents("scripts/prefs.json");
      $prefs = json_decode($json, true);
      ?>
      <?php
      if($prefs["next"]==true) {
       echo '<a class="flexcard" href="http://'. $prefs["hostname"] .'.local/nextcloud"><div class="logo" style="background: url(logo/nextcloud.png); background-size: cover;"></div><h1>Nextcloud</h1></a>';
  }
       if($prefs["rocket"]==true) {
       echo '<a class="flexcard" href="http://'. $prefs["hostname"] .'.local:3000"><div class="logo" style="background: url(logo/rocketchat.png); background-size: cover;"></div><h1>Rocket.Chat</h1></a>';
  }
          if($prefs["plex"]==true) {
           echo '<a class="flexcard" href="http://'. $prefs["hostname"] .'.local:32400/web"><div class="logo" style="background: url(logo/plex.jpeg); background-size: cover;"></div><h1>Plex</h1></a>';
}
    if($prefs["wiki"]==true) {
      echo '<a class="flexcard" href="http://'. $prefs["hostname"] .'.local:9454"><div class="logo" style="background: url(logo/wiki.png); background-size: cover;"></div><h1>Zimply</h1></a>';
   }
       if($prefs["webmin"]==true) {
      echo '<a class="flexcard" href="https://'. $prefs["hostname"] .'.local:10000"><div class="logo" style="background: url(logo/webmin.png); background-size: cover;"></div><h1>Webmin</h1></a>';
   }
   if($prefs["gitlab"]==true) {
    echo '<a class="flexcard" href="http://'. $prefs["hostname"] .'.local:6969"><div class="logo" style="background: url(logo/gitlab.png); background-size: cover;"></div><h1>GitLab</h1></a>';
   }
      if($prefs["phet"]==true) {
    echo '<a class="flexcard" href="http://'. $prefs["hostname"] .'.local/phet"><div class="logo" style="background: url(logo/phet.png); background-size: cover;"></div><h1>PhET</h1></a>';
   }
    ?>
    </div>
  <script type="text/javascript">
  var items = ['cliffs', 'beach', 'sand', 'mountains', 'forests'];
  var seed = items[Math.floor(Math.random()*items.length)];
  function backdrop() {
    console.log(seed);
    if(seed == 'cliffs') {
      document.getElementById('banner').style.backgroundImage = "url(backdrops/cliffs.jpg)";
      document.getElementById("description").innerHTML = 'Photo by <a href="https://unsplash.com/@caleb_carl?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Caleb Carl</a> on <a href="https://unsplash.com/images/stock?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>';
    }
    else if(seed == 'beach') {
      document.getElementById('banner').style.backgroundImage = "url(backdrops/beach.jpg)";
      document.getElementById("description").innerHTML = 'Photo by <a href="https://unsplash.com/@guzmanbarquin?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Guzmán Barquín</a> on <a href="https://unsplash.com/images/stock?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>';
    }
    else if(seed == 'sand'){
      document.getElementById('banner').style.backgroundImage = "url(backdrops/sand.jpg)";
      document.getElementById("description").innerHTML = 'Photo by <a href="https://unsplash.com/@noahnkb?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Noah Bikoro</a> on <a href="https://unsplash.com/s/photos/desert?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>';
    }
    else if(seed == 'mountains'){
      document.getElementById('banner').style.backgroundImage = "url(backdrops/mountains.jpg)";
      document.getElementById("description").innerHTML = 'Photo by <a href="https://unsplash.com/@mitchorr?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Mitchell Orr</a> on <a href="https://unsplash.com/images/stock?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>';
    }
    else if(seed == 'forests'){
      document.getElementById('banner').style.backgroundImage = "url(backdrops/forests.jpg)";
      document.getElementById("description").innerHTML = 'Photo by <a href="https://unsplash.com/@landscapeplaces?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Federico Bottos</a> on <a href="https://unsplash.com/s/photos/forest?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText">Unsplash</a>';
    }
  }
  backdrop();
window.setInterval(function() {
  var hour = new Date().getHours();
  var greeting;
  if (hour < 12) {
      greeting = "Good Morning";
  } else if (hour < 18 && hour >= 12) {
      greeting = "Good Afternoon";
  } else {
      greeting = "Good Evening";
  }
  document.getElementById("greeting").innerHTML = greeting;
}, 1000);
  window.setInterval(function() {
    var online = window.navigator.onLine;
    var status1;
    if (online) {
      status1 = "Online";
      document.getElementById("status").style.color = "#37FF8B";
    } else {
      status1 = "Offline";
      document.getElementById("status").style.color = "#D11b1b";
    }
    document.getElementById("status").innerHTML = status1;

  }, 1000);
  </script>
  </body>
</html>
