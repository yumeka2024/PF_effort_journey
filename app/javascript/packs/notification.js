  window.onRead = () =>{
    console.log("OnRead");
    const elements = document.getElementsByClassName("notification-id");
    console.log(elements)
    const ids= [];
    for( var i = 0; i< elements.length; i++){
        var elem = elements[i]
        ids.push(elem.getAttribute("data-notification-id"))
    }
    if(ids.length){
      fetch(`/notifications/${ids}`, {
              method: 'PATCH',
              headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': getCsrfToken()
              }
      });
    }
  }
  const getCsrfToken = () => {
      const metas = document.getElementsByTagName('meta');
      for (let meta of metas) {
          if (meta.getAttribute('name') === 'csrf-token') {
              console.log('csrf-token:', meta.getAttribute('content'));
              return meta.getAttribute('content');
          }
      }
      return '';
  }
