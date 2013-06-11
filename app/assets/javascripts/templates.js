$(function() {
    $("#html-body").load(function() {
        $(this).height( $(this).contents().find("body").height() + 100);
    });

    $("#errors").load(function() {
        $(this).height( $(this).contents().find("body").height() + 100);
    });

    function dataUri(html) {
        return 'data:text/html;charset=UTF-8,' + encodeURIComponent(html)
    }

    function showResults(from, subject, html, plain, raw, errors) {
        $('#html-from').text("From: " + from);
        $('#html-subject').text("Subject: " + subject);
        $('#html-body').attr('src', dataUri(html));

        $('#plain-from').text("From: " + from);
        $('#plain-subject').text("Subject: " + subject);
        $('#plain-body').text(plain);

        $('#raw').text(raw);

        $('#errors').attr('src', dataUri(errors));
    }

    function tryItMaybeSendIt(sendIt) {
        $.ajax({
            type: 'POST',
            url: '/templates/try.json',
            data: {
                from:    $('#template_from').val(),
                subject: $('#template_subject').val(),
                html:    $('#template_html').val(),
                plain:   $('#template_plain').val(),
                data:    $('#template_example').val(),
                to:      $('#to').val(),
                send:    sendIt
            },
            success: function(data, status, xhr) {
                console.log(data);
                $('.tabbable .nav-tabs a[href=#tab1]').tab('show');
                showResults(data.from,
                            data.subject,
                            data.html,
                            data.plain,
                            data.raw,
                            '');
                if (sendIt) {
                    $('#sent-alert').html('<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">&times;</button>Sent</div>');

                }
            },
            error: function(xhr, status, err) {
                $('.tabbable .nav-tabs a[href=#tab4]').tab('show');
                showResults('',
                            '',
                            '',
                            '',
                            '',
                            xhr.responseText);
            }
        })
    }

    $('#try-it').click(function(event) {
        event.preventDefault();
        tryItMaybeSendIt(false);
    });

    $('#send-it').click(function(event) {
        event.preventDefault();
        tryItMaybeSendIt(true);
    });

    $("form.edit_template").on("ajax:complete", function(xhr, data, status) {
        $('#saved-alert').html('<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">&times;</button>Saved</div>');
    });

});
