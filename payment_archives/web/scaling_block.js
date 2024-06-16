document.addEventListener('wheel', function(e) {
    e.ctrlKey && e.preventDefault();
  }, {
    passive: false,
  });
  window.addEventListener('keydown', function(e) {
    if (event.metaKey || event.ctrlKey) {
      switch (event.key) {
        case '=':
        case '-':
        case '+':  
          event.preventDefault();
          break;
      }
    }
  });