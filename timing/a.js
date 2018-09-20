var a = require('./alice.cp2.json');

a.timing.map(function (e) {
   console.log(e.bib+ ";" + e.name);
})
