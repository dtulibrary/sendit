Tsushin - Communication server
==============================

This application provides a central, template-based email delivery service.

Templates are editable and available at `/templates`. From- and subject-fields as well as plain text and html message bodies are all evaluated as ERB with the supplied JSON document as the binding (i.e. data defined in the JSON document is accesible as instance variables inside the ERB).

To send email based on a given template you should POST a json document to `/send/:template_name`.

Example
-------

Given a template (let's assume that it is saved with the name `test.template`) with the following definitions:

From:

    <%= @from %>

Subject:

    <%= @subject %>

Plain:

    This is the plain text part.
    The time now is <%= Time.now %>.
    The contents of the "test" variable is: <%= @test %>.

HTML:

    <html><body>
    <p>This is the html part.</p>
    <p>The time now is <%= Time.now %>.</p>
    <p>The contents of the "test" variable is: <code><%= @test %></code></p>
    </body></html>

Posting the following json to `/send/test.template`

    { "to": "somebody@example.com", "from": "anybody@example.com", subject": "Read this", test": "Hello world!" }

Will generate the following email message

    Date: Tue, 11 Jun 2013 08:30:10 +0200
    From: anybody@example.com
    To: somebody@example.com
    Message-ID: <51b6c3f2a94cc_12cec3fe33f693e0058768@meeny.mail>
    Subject: Read this
    Mime-Version: 1.0
    Content-Type: multipart/alternative;
     boundary="--==_mimepart_51b6c3f2a80dd_12cec3fe33f693e005865d";
     charset=UTF-8
    Content-Transfer-Encoding: 7bit


    ----==_mimepart_51b6c3f2a80dd_12cec3fe33f693e005865d
    Content-Type: text/plain;
     charset=UTF-8
    Content-Transfer-Encoding: 7bit

    This is the plain text part.
    The time now is 2013-06-11 08:30:10 +0200.
    The contents of the "test" variable is: Hello world!.

    ----==_mimepart_51b6c3f2a80dd_12cec3fe33f693e005865d
    Content-Type: text/html;
     charset=UTF-8
    Content-Transfer-Encoding: 7bit

    <html><body>
    <p>This is the html part.</p>
    <p>The time now is 2013-06-11 08:30:10 +0200.</p>
    <p>The contents of the "test" variable is: <code>Hello world!</code></p>
    </body></html>
    ----==_mimepart_51b6c3f2a80dd_12cec3fe33f693e005865d--

and send it to `somebody@example.com`.

Access control.
--------------

Authentication and authorization for template editing is done by CAS.

Authentication for the send API is IP based.
