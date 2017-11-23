<script>
if ($("#annotations_on_off").text().trim() === "on") {
    if (typeof annotator === 'undefined') {
          alert("Oops! Something went wrong and Annotator isn't loaded.");
    } else {
        var app = new annotator.App();
        app.include(annotator.ui.main,{
              element: document.querySelector('div.toc-content'),
              editorExtensions: [annotator.ui.tags.editorExtension],
              viewerExtensions: [annotator.ui.tags.viewerExtension]
            })
            .include(annotatorImageSelect, {
              element: $('.main-container img')
           })
          .include(annotator.storage.http, {
            prefix: 'http://api.ea.ioki.pl:6678',
            //prefix: 'http://0.0.0.0:6678',
            urls: {
                create: '/annotations',
                update: '/annotations/{id}',
                destroy: '/annotations/{id}',
                search: '/search'
            },
            headers: {
                'document': document.location.pathname.match(/[^\/]+$/)[0],
                'full_document_address': window.location.href,
                'document_owner_email': $("#recipient-email").text()
            }
          });
          
        app.start().then(function () {
             app.annotations.load();
        });
      }
}
</script>
