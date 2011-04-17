---
created_at: 2011-04-17 20:36:00.988605 +02:00
layout: post
title: Rails-es Ajax megoldások
author: "B\xC3\xA1lint"
author_uri: http://www.codigoergosum.com
---

Az áprilisi alkalomra kicsit formát bontunk. [Chad Fowler egyik post-ja](http://chadfowler.com/2011/02/09/how-rails-developers-do-ajax-with-jquery-in-2011) arra kérdezett rá, hogy ki hogyan oldja meg a Rails és az AJAX társítását. Erre elég sokféle megoldás létezik, és arra gondoltunk, hogy érdekes lehet ezeket végigvenni a következő budapest.rb-n. Íme az ott előkerülő megoldások:

 * mustache.js
 * Sending JavaScript back down to the client using .js.erb template files
 * jQuery templates
 * Hitting RESTFUL endpoints and responding with JSON data to be manipulated on the client
 * backbone.js
 * Rendering partials and updating elements on the page with their raw content (the original old-school Rails way of doing it)
 * SammyOnRails

 A dolog úgy működne, hogy akinek kedve van, választ egyet magának a fenti listából, és azt egy kb. 15 perces előadás keretében bemutatja. Az az igazi, ha ezt egy működő "alkalmazáson" keresztül teszi, de az idő rövidsége miatt ez nem feltétel. Természetesen nem vagytok korlátozva a fenti listára, bármilyen más megoldás ugyanolyan jó! Ha választottál, hagyj itt egy kommentet, hogy más azt már ne válassza.

 Segíts, hogy csütörtökön legalább 3-4 megoldást lássunk teljes pompájában!

