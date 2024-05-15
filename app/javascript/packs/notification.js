//  document.addEventListener('DOMContentLoaded', function() {
  //document.addEventListener('DOMContentLoaded', function() {
  window.onRead = () =>{
    console.log("OnRead");
    const elements = document.getElementsByClassName("notification-id");
    const ids= [];
    for( var i = 0; i< elements.length; i++){
        var elem = elements[i]
        ids.push(elem.getAttribute("data-notification-id"))
    }
    fetch(`/notifications/${ids}`, {
            method: 'PATCH',
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': getCsrfToken()
            }
    });

    /*
    // indexアクションから通知データを取得
    fetch(`/notifications.json?page=page`)
      .then(response => response.json())
      .then(notifications => {
        console.log(notifications);
        // 取得した通知データを処理
        const ids= [];
        notifications.forEach(notification => {
          ids.push(notification.id)
        });

          // 各通知のIDを使ってreadカラムを更新するためのリクエストを送信
        fetch(`/notifications/${ids}`, {
            method: 'PATCH',
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': getCsrfToken()
            }
        });
      });
      */
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
