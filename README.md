Tsushin - Communication server
==============================

This module is intended as a service with which to send formatted e-mail, sms
or other types of messages to users based on user (administrator) editable
templates.

The intention is to have all templates in this one place and allow
other services/interface to send the information they want sent out and
let this service do the actual formatting based on a template stored here.

It is also the intention to allow to build and test a new set of email
templates, before deploying a new layout for all templates.

To use this you send a REST GET request

   http://service.dom.ain/send/<template name>?options=?&data=<json>

Data may also be posted (as a JSON structure) through the same URL but as POST.

   http://service.dom.ain/send/template_name?options=?

data is available for the template during parsing.


Limiting access to the service
------------------------------
For the sending this is intended to be done in Apache, normally based on IP
restriction. So no measures are taken in this code.

Limitation on who can edit is done through active admin module.
