function cynthia_cizer(speed, wave, text){
var audio = new window.webkitAudioContext();
       
        position = 0
        
        scale = {a: 146.8,  b: 2960,  c: 23.12,  d: 32.70,  e: 7902,  f: 116.5,  g: 622.3,  h: 19.45,  
                 i: 3136,
                 j: 17.32, k: 9398, l: 110, m: 523.3, n: 21.83, o: 7040, p: 58.27, q: 92.50, r: 138.6,
                 s: 2349, t: 622.3, u: 30.87, v: 1047, w: 77.78, x: 39.51, y: 415.3, z: 16.35}

        song = text;

    setInterval(play, speed / 4);

    function createOscillator(freq) {
        var attack = 10,
            decay = 250,
            gain = audio.createGain(),
            osc = audio.createOscillator();
 
        gain.connect(audio.destination);
        gain.gain.setValueAtTime(0, audio.currentTime);
        gain.gain.linearRampToValueAtTime(1, audio.currentTime + attack / 1000);
        gain.gain.linearRampToValueAtTime(0, audio.currentTime + decay / 1000);
 
        osc.frequency.value = freq;
        osc.type = wave;
        osc.connect(gain);
        osc.start(0);
         
        setTimeout(function() {
            osc.stop(5);
            osc.disconnect(gain);
            gain.disconnect(audio.destination);
        }, decay)
    }
 
    function play() {
        var note = song.charAt(position),
            freq = scale[note];
        position += 1;
        if(position >= song.length) {
            position = 0;
        }
        if(freq) {
            createOscillator(freq);
        }
    }

 };