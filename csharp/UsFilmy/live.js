﻿// Copyright (c) Microsoft Corporation.  All rights reserved. 
// Use of this code is governed by the Terms of Use located at: http://dev.live.com/contactscontrol/gadgettou.aspx
// and http://dev.live.com/spacescontrol/gadgettou.aspx
registerNamespace=function(f){if(typeof Type!="undefined"&&typeof Type.registerNamespace=="function")return Type.registerNamespace(f);var d=window,c=f.split(".");for(var b=0;b<c.length;b++){var e=c[b],a=d[e];if(!a){a=d[e]={};if(b===0){if(!window.__rootNamespaces)window.__rootNamespaces=[];window.__rootNamespaces[window.__rootNamespaces.length]=a}}if(!a.__namespace){a.__namespace=true;a.__typeName=c.slice(0,b+1).join(".");a.getName=function g(){return this.__typeName}}d=a}};registerNamespace("Microsoft.Live.Platform");Microsoft.Live.Platform.baseURL=window.location.protocol+"//controls.services.live.com/scripts/base/v0.3/";Microsoft.Live.Platform.scriptURL=Microsoft.Live.Platform.baseURL;Microsoft.Live.Platform.addEvent=function(a,b,c){if(a.addEventListener)a.addEventListener(b,c,false);else if(a.attachEvent)a.attachEvent("on"+b,c)};Microsoft.Live.Platform.removeEvent=function(a,b,c){if(a.removeEventListener)a.removeEventListener(b,c,false);else if(a.detachEvent)a.detachEvent("on"+b,c)};Microsoft.Live.Platform.uniqueID=function(a){var b=a+Math.floor(Math.random()*1024*1024);if(document.getElementById(b))return Microsoft.Live.Platform.uniqueID(a);return b};Microsoft.Live.Platform.escapeRegExp=function(a){var b=new RegExp("(\\+|\\/|\\*|\\?|\\||\\{|\\[|\\(|\\)|\\^|\\$|\\#|\\.|\\}|\\])","g");return a?a.replace(/(\\)/g,"\\\\").replace(b,"\\$1"):""};Microsoft.Live.Platform.expandURL=function(e,f){var a;if(!e||e.length==0){var g=window.location.protocol+"//"+window.location.host+window.location.pathname;a=g.split("/");a.pop()}else a=e.replace(/\\/g,"/").split("/");if(a.length>0&&a[a.length-1].length==0)a.pop();if(f&&f.length>0){var b=f.replace(/\\/g,"/").split("/"),c;if(b.length>0){c=b[0];var d;if(a.length>=2&&a[0].substr(a[0].length-1)==":"&&a[1].length==0)d=3;else d=1;if(c.length==0){a.length=d;b.shift()}else if(c.substr(c.length-1)==":")return b.join("/");b.reverse();for(;b.length>0;){c=b.pop();switch(c){case ".":break;case "..":if(a.length>d)a.pop();break;default:a.push(c)}}}}return a.join("/")};Microsoft.Live.Platform.findHash=function(a){var b=a.indexOf("#");if(b>=0&&typeof a=="string")return a.substring(b);return ""};Microsoft.Live.Platform.findParams=function(a){var b=a.indexOf("?");if(b>=0&&typeof a=="string")return a.substring(b);return ""};Microsoft.Live.Platform.expandURLs=function(d,a){if(!a)return null;var c=new Array(a.length);for(var b=0;b<a.length;b++)c[b]=Microsoft.Live.Platform.expandURL(d,a[b]);return c};Microsoft.Live.Platform.format=function(){var b=arguments[0],d="",c=0;for(var a=0;a<b.length;a++)if(b.charAt(a)=="%")if(arguments[b.charAt(a+1)]){d+=b.substr(c,a-c)+arguments[b.charAt(a+1)];a++;c=a+1}else if(b.charAt(a+1)>=1&&b.charAt(a+1)<=9){d+=b.substr(c,a-c);a=a+2;c=a+2}if(c<b.length)d+=b.substr(c);return d};Microsoft.Live.Platform._load={list:[],onLoads:[],onErrors:[],loading:0};Microsoft.Live.Platform.load=function(d,i,h){function j(c,b){for(var a=b.length-1;a>=0;a--)c.push(Microsoft.Live.Platform.expandURL("",b[a]))}var b=Microsoft.Live.Platform._load;if("string"===typeof d)b.list.push(d);else j(b.list,d);if(i)b.onLoads.push(i);if(h)b.onErrors.push(h);if(!b.loading)a();function a(){var d=Microsoft.Live.Platform._load;if(d.list.length>0){d.loading=1;var e=d.list.pop();if(e.indexOf("://")==0)e=Microsoft.Live.Platform.expandURL("",e);var h=document.getElementsByTagName("script"),b;for(var i=0;i<h.length;i++){b=h[i];if(b.src==e)if(b.readyState=="loaded"||b.readyState=="complete"){d=e=h=b=null;a();return}else{Microsoft.Live.Platform.addEvent(b,"load",g);Microsoft.Live.Platform.addEvent(b,"error",f);Microsoft.Live.Platform.addEvent(b,"readystatechange",c);d=e=h=b=null;return}}h=null;b=document.createElement("script");b.type="text/javascript";Microsoft.Live.Platform.addEvent(b,"load",g);Microsoft.Live.Platform.addEvent(b,"error",f);Microsoft.Live.Platform.addEvent(b,"readystatechange",c);b.src=e;document.getElementsByTagName("head")[0].appendChild(b)}else{var j,k=d.list.length;for(;d.onLoads.length>0;){j=d.onLoads.pop();try{j();if(d.list.length>k){a();return}}catch(l){}}d.loading=0}}function c(c){if(!c)c=system.event;var b=c.srcElement;if(b.readyState=="loaded"||b.readyState=="complete"){e(b);a()}}function g(){this.readyState="complete";e(this);a()}function f(){this.readyState="complete";e(this);var b;for(;Microsoft.Live.Platform._load.onErrors.length>0;){b=Microsoft.Live.Platform._load.onErrors.pop();try{b(this)}catch(c){}}a()}function e(a){Microsoft.Live.Platform.removeEvent(a,"load",g);Microsoft.Live.Platform.removeEvent(a,"error",f);Microsoft.Live.Platform.removeEvent(a,"readystatechange",c)}};Microsoft.Live.Platform.loadFrom=function(c,a,e,d){var b;if("string"===typeof a)b=Microsoft.Live.Platform.expandURL(c,a);else b=Microsoft.Live.Platform.expandURLs(c,a);Microsoft.Live.Platform.load(b,e,d)};Microsoft.Live.Platform.using=function(a,d,c){if("string"===typeof a)a=[a];for(var b=0;b<a.length;b++)a[b]=Microsoft.Live.Platform.scriptURL+a[b]+".js";Microsoft.Live.Platform.load(a,d,c)};Microsoft.Live.Platform.getCookie=function(b){var a=document.cookie.match(b+"=(.*?)(;|$)");if(a)return unescape(a[1]);else return null};Microsoft.Live.Platform.deleteCookie=function(b,c,a){var d=new Date(0);document.cookie=b+"=;expires="+d.toGMTString()+";path="+c+";domain="+a+";"};Microsoft.Live.Platform.sanitizeColor=function(a){var b=new RegExp("^(#[0-9a-fA-F]{1,6}|rgb\\([0-9]{1,3}%?,[0-9]{1,3}%?,[0-9]{1,3}%?\\)|aqua|black|blue|fuchsia|gray|green|lime|maroon|navy|olive|purple|red|silver|teal|white|yellow)$");if(b.test(a))return a;else return null};Microsoft.Live.Platform.Hesc=function(a){return a.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/\"/g,"&quot;").replace(/\'/g,"&#39;")};Microsoft.Live.Platform.setLocaleFontFamily=function(a,b,c){if(a){if(b)a.style.fontFamily=b;if(c)a.style.fontSize=c}};Microsoft.Live.Platform.GetWindowWidth=function(a){var b;if(a.innerWidth)b=a.innerWidth;else if(a.document.documentElement&&a.document.documentElement.clientWidth)b=a.document.documentElement.clientWidth;else if(a.document.body&&a.document.body.clientWidth)b=a.document.body.clientWidth;return b};Microsoft.Live.Platform.GetTruncatedString=function(a,d,c){if(d<c*a.length){var b=null;b=a.substring(0,d/c-4);if(a.length>b.length){b+="...";a=b}}return a};Microsoft.Live.ArgumentException=function(a){this.name="ArgumentException";this.message=a;Microsoft.Live.ArgumentException.prototype.toString=function(){return this.name+": "+this.message}};Microsoft.Live.InvalidOperationException=function(a){this.name="InvalidOperationException";this.message=a;Microsoft.Live.InvalidOperationException.prototype.toString=function(){return this.name+": "+this.message}};if("undefined"===typeof window.XMLHttpRequest)window.XMLHttpRequest=function(){var b=["MSXML2.XMLHttp.5.0","MSXML2.XMLHttp.4.0","MSXML2.XMLHTTP","Microsoft.XMLHTTP"];for(var a=0;a<b.length;a++)try{var c=new ActiveXObject(b[a]);return c}catch(d){}return null};if("undefined"===typeof window.location.replace)window.location.replace=window.location.assign;registerNamespace("Microsoft.Live.Channels");if(navigator.userAgent.indexOf("Firefox")>-1)Microsoft.Live.Channels.useFlashTransport=false;Microsoft.Live.Channels.baseURL=Microsoft.Live.Platform.expandURL(Microsoft.Live.Platform.baseURL,"../../channel/v0.3/");Microsoft.Live.Channels.scriptURL=Microsoft.Live.Platform.expandURL(Microsoft.Live.Platform.scriptURL,"../../channel/v0.3/");Microsoft.Live.Channels.secureScriptURL=Microsoft.Live.Platform.expandURL(Microsoft.Live.Platform.scriptURL,"../../channel/v0.3/").replace("http://","https://");registerNamespace("Microsoft.Live.Channels.Internal");Microsoft.Live.Channels.SendCounts=0;Microsoft.Live.Channels.SendBytes=0;Microsoft.Live.Channels.Transport="";Microsoft.Live.Channels.Internal.trackImg=new Image;Microsoft.Live.Channels.Internal.track=function(b,c,d,e){var a="https://controls.services.live.com/usage.ashx?domain=%1&control=%2&version=v0.3o&action=%3&info=%4&rnd=%5&more=%6";Microsoft.Live.Channels.Internal.trackImg.src=Microsoft.Live.Platform.format(a,encodeURIComponent(document.location.hostname),b,c,encodeURIComponent(d||""),Math.random(),e)};if("undefined"===typeof Microsoft.Live.Channels.Internal.logger||Microsoft.Live.Channels.Internal.logger===null)Microsoft.Live.Channels.Internal.logger=setInterval(function $trackSends(){if(Microsoft.Live.Channels.SendCounts>0){var a=Microsoft.Live.Channels.Transport!="slow"?"flash.send":"javascript.send";Microsoft.Live.Channels.Internal.track("ifm",a,Microsoft.Live.Channels.SendBytes,Microsoft.Live.Channels.SendCounts);Microsoft.Live.Channels.SendCounts=0;Microsoft.Live.Channels.SendBytes=0}},20000);Microsoft.Live.IfmFrame=function(k,c,d,e,h,i){var a=document.getElementById(k),j=Microsoft.Live.Channels.Internal,l=Microsoft.Live.Platform;if(!c||c.length==0);if(!e){var f=c.split("/");if(f&&f.length>3)e=f[0]+"//"+f[2]+"/channel.htm"}if(!d)d=document.location.protocol+"//"+document.location.host+"/channel.htm";d=Microsoft.Live.Platform.expandURL("",d);var b=document.createElement("iframe"),m=a.style;b["scrolling"]=a["scrolling"]||"no";b["width"]="100%";b["height"]="100%";b["align"]=a["align"]||"left";b["frameBorder"]=a["frameborder"]=="yes"||a["frameborder"]=="1"?1:0;b.id=b.name=l.uniqueID("ifm");if(c.indexOf("#")==-1)c+="#";c+="&WLIFMp="+encodeURIComponent(d)+"&WLIFMi="+encodeURIComponent(b.id);if(j.testFlashVersion(7,0)){Microsoft.Live.Channels.Internal.track("ifmframe","instantiate","flash");var g=Microsoft.Live.Channels.Internal.getDomainFromURL(e);a.channel=new Microsoft.Live.Channels.FlashChannel(g,b.id,g);a.channel.onReceiveMessage=h;a.channel.onError=i;Microsoft.Live.Channels.Transport=a.transport="fast";c+="&WLIFMt=f"}else{Microsoft.Live.Channels.Internal.track("ifmframe","instantiate","javascript");a.channel=new Microsoft.Live.Channels.Channel("",d,g);a.channel.onReceiveMessage=h;a.channel.onError=i;a.channel.connect(b.id,e);Microsoft.Live.Channels.Mux.register_recver(b.id,e,a.channel.onReceiveMessage,true);Microsoft.Live.Channels.Transport=a.transport="slow";c+="&WLIFMt=i"}b.src=c;a.appendChild(b);a.channel.setReceiver=function(c){if(typeof c=="function")if(j.testFlashVersion(7,0))a.channel.onReceiveMessage=c;else{a.channel.onReceiveMessage=c;Microsoft.Live.Channels.Mux.register_recver(b.id,e,a.channel.onReceiveMessage,true)}};return a};Microsoft.Live.IfmChannel=function(n,d,e,h,k){if(self.location==top.location){top.location="about:blank";throw new Error("This website must be inside of an Iframe to be used.");return}var l=Microsoft.Live.Channels.Internal,b=null,c=null;if("undefined"!==typeof window.name&&window.name!=="")try{c=window.name.replace(new RegExp("(\\W)+","gi"),"")}catch(o){c=null}var j=null;function m(){var e=document.URL?document.URL:document.location.href,d=Microsoft.Live.Platform.findHash(e).substr(1).split("&"),f={};if(d&&d.length>0){var a;for(i=0;i<d.length;i++){a=d[i].split("=");if(a&&a.length==2)switch(a[0]){case "WLIFMp":b=decodeURIComponent(a[1]);break;case "WLIFMi":if(c==null)c=decodeURIComponent(a[1]).replace(new RegExp("(\\W)+","gi"),"");break;case "WLIFMt":j=a[1]}}}}var a=document.getElementById(n);m();if(!d||d.length==0){Microsoft.Live.Channels.Internal.track("ifmchannel","error","no domain names were provided");return}if(!b||b.length==0){Microsoft.Live.Channels.Internal.track("ifmchannel","error","invalid parent channel");return}var f=Microsoft.Live.Platform.escapeRegExp(d);f=f.replace(/\\\*/g,".*");f="^(("+f.replace(/,/g,")|(")+"))$";var g=Microsoft.Live.Channels.Internal.getDomainFromURL(b);if(!g.match(new RegExp(f))){Microsoft.Live.Channels.Internal.track("ifmchannel","error","invalid domain");return}if(!e)e=document.location.protocol+"//"+document.location.host+"/channel.htm";e=Microsoft.Live.Platform.expandURL("",e);if(l.testFlashVersion(7,0)&&j=="f"){Microsoft.Live.Channels.Internal.track("ifmchannel","instantiate","flash");a.channel=new Microsoft.Live.Channels.FlashChannel(d,c,g);a.channel.onReceiveMessage=h;a.channel.onError=k;Microsoft.Live.Channels.Transport=a.transport="fast"}else{Microsoft.Live.Channels.Internal.track("ifmchannel","instantiate","javascript");a.channel=new Microsoft.Live.Channels.Channel(c,e,g);a.channel.onReceiveMessage=h;a.channel.onError=k;a.channel.allowDomains=d;a.channel.connect("",b);Microsoft.Live.Channels.Mux.register_recver("",b,a.channel.onReceiveMessage,true);Microsoft.Live.Channels.Transport=a.transport="slow"}a.channel.setReceiver=function(c){if(typeof c=="function")if(l.testFlashVersion(7,0))a.channel.onReceiveMessage=c;else{a.channel.onReceiveMessage=c;Microsoft.Live.Channels.Mux.register_recver("",b,a.channel.onReceiveMessage,true)}};return a};registerNamespace("Microsoft.Live.Channels.Mux");function OneShotSemaphore(){this.signal=function(){var c;if(!b){b=true;for(var d=0;d<a.length;d++){c=a[d];if(c)try{c()}catch(e){}}a=[]}};this.reset=function(){b=false};this.waitFor=function(a){if(b)a();else c(a)};this.isSignalled=function(){return b};var a=[],b=false,c=function(b){a.push(b)},d=function(c){var b=a.indexOf(c);if(b>=0)a[b]=null}}Microsoft.Live.Channels.Mux._channels={};Microsoft.Live.Channels.Mux._chanids={};Microsoft.Live.Channels.Mux._srcurls={};Microsoft.Live.Channels.Mux._receivers={};Microsoft.Live.Channels.Mux._ackcounters={};if("undefined"==typeof Microsoft.Live.Channels.Mux._uniqueids)Microsoft.Live.Channels.Mux._uniqueids=[];Microsoft.Live.Channels.Internal._addIDs=function(){var a;for(a=0;a<arguments.length;a++)Microsoft.Live.Channels.Mux._uniqueids.push(arguments[a]);var b=Microsoft.Live.Channels.Mux._uniqueIdMutex;Microsoft.Live.Channels.Mux._uniqueIdMutex=null;b.signal()};Microsoft.Live.Channels.Mux._getUniqueId=function(b){if(Microsoft.Live.Channels.Mux._uniqueids.length==0){var a=Microsoft.Live.Channels.Mux._uniqueIdMutex?true:false;if(!a)Microsoft.Live.Channels.Mux._uniqueIdMutex=new OneShotSemaphore;Microsoft.Live.Channels.Mux._uniqueIdMutex.waitFor(function(){Microsoft.Live.Channels.Mux._getUniqueId(b)});if(!a){var c=document.createElement("script");c.src=Microsoft.Live.Channels.scriptURL+"uniqid2.aspx?numids=10&u="+Math.random();document.getElementsByTagName("head")[0].appendChild(c)}}else b(Microsoft.Live.Channels.Mux._uniqueids.pop())};Microsoft.Live.Channels.Mux._encode=function(a){if("string"!=typeof a)a="";a=encodeURIComponent(a);return a.replace(/%/g,"\\")};Microsoft.Live.Channels.Mux._decode=function(a){if("string"!=typeof a)a="";a=a.replace(/\\/g,"%");return decodeURIComponent(a)};Microsoft.Live.Channels.Mux._clean_iframes=function(c){var b;switch(c){case "S":default:b="Microsoft.Live.Channels.Mux.Sframe";break;case "R":b="Microsoft.Live.Channels.Mux.Rframe"}var a=document.getElementById(b);if(a){a.parentNode.removeChild(a);a=null}};Microsoft.Live.Channels.Mux._send_chunk=function(c,d){try{var a;switch(c){case "S":default:a="Microsoft.Live.Channels.Mux.Sframe";break;case "R":a="Microsoft.Live.Channels.Mux.Rframe"}var b=document.getElementById(a);if(!b){Microsoft.Live.Channels.Mux.init_iframes();b=document.getElementById(a)}b.src=d}catch(e){}};Microsoft.Live.Channels.Mux._CountACKs=function(a,b){var c=false;if(!Microsoft.Live.Channels.Mux._ackcounters[a])Microsoft.Live.Channels.Mux._ackcounters[a]={ackid:0,count:0};if(Microsoft.Live.Channels.Mux._ackcounters[a].ackid==b){if(Microsoft.Live.Channels.Mux._ackcounters[a].count>=5){c=true;Microsoft.Live.Channels.Mux._ackcounters[a].count=0}}else Microsoft.Live.Channels.Mux._ackcounters[a].count=0;Microsoft.Live.Channels.Mux._ackcounters[a].ackid=b;Microsoft.Live.Channels.Mux._ackcounters[a].count++;return c};Microsoft.Live.Channels.Mux._recv_chunk=function(f){if("string"!=typeof f)f=f.hash.substr(1);var e=f.split("/"),a=e[1],i=e[2].substr(0,1),c=parseInt(e[2].substr(1),16),h=e[3],l=e.length>4?e[4]:null;switch(i){case "S":var d=a;if("undefined"==typeof Microsoft.Live.Channels.Mux._chanids[d])Microsoft.Live.Channels.Mux._getUniqueId(function(a){Microsoft.Live.Channels.Mux._chanids[d]=a;Microsoft.Live.Channels.Mux._recv_chunk(f)});else{a=Microsoft.Live.Channels.Mux._chanids[d];var b=Microsoft.Live.Channels.Mux._decode(h),k=Microsoft.Live.Channels.Mux._CountACKs(a,c);if(k)Microsoft.Live.Channels.Mux._clean_iframes("R");else{var j=b+d+"/R"+c.toString(16)+"/"+a+"/"+document.location.hostname;Microsoft.Live.Channels.Mux._send_chunk("R",j)}if("undefined"==typeof Microsoft.Live.Channels.Mux._srcurls[a]&&b!=null){Microsoft.Live.Channels.Mux._srcurls[a]=b;if("undefined"==typeof Microsoft.Live.Channels.Mux._receivers[b])Microsoft.Live.Channels.Mux._receivers[b]=new Microsoft.Live.Channels.Mux._Receiver(b);Microsoft.Live.Channels.Mux._receivers[b]._set_chunkid(c)}}break;case "R":var d=a;a=Microsoft.Live.Channels.Mux._decode(h);if("undefined"!=typeof Microsoft.Live.Channels.Mux._channels[d]){var g=Microsoft.Live.Channels.Mux._channels[d];if(g._validate_sender(l)){if("undefined"==typeof Microsoft.Live.Channels.Mux._channels[a]){Microsoft.Live.Channels.Mux._channels[a]=g;g._set_chanid(a);g._recv_chunk(a,c)}}else return}break;case "C":case "L":if("undefined"!=typeof Microsoft.Live.Channels.Mux._srcurls[a]){var b=Microsoft.Live.Channels.Mux._srcurls[a],k=Microsoft.Live.Channels.Mux._CountACKs(a,c),j=b+a+"/A"+c.toString(16);if(k)Microsoft.Live.Channels.Mux._clean_iframes("R");else Microsoft.Live.Channels.Mux._send_chunk("R",j);Microsoft.Live.Channels.Mux._receivers[b]._recv_chunk(i,c,h)}break;case "X":if("undefined"!=typeof Microsoft.Live.Channels.Mux._srcurls[a])Microsoft.Live.Channels.Mux._receivers[b]._recv_abort(c);break;case "A":if("undefined"!=typeof Microsoft.Live.Channels.Mux._channels[a])Microsoft.Live.Channels.Mux._channels[a]._recv_chunk(a,c)}};Microsoft.Live.Channels.Mux._Receiver=function(g){var b=this,d,e,c,a=[];b.recver=null;var f=g.split("#");d=f[1].split("/")[0];e=f[0];a.push(null);b._set_chunkid=function(a){c=a;c++};b._recv_chunk=function(e,f,g){if(c!=f)return;c++;var d=a[a.length-1];if(null==d)d="";d+=g;a[a.length-1]=d;if("L"==e)a.push(null);b._recv()};b._recv_abort=function(b){if(c!=b)return;a=[]};b._recv=function(){if(null==b.recver)return;var c;for(var f=0;a.length-1>f;f++){c=Microsoft.Live.Channels.Mux._decode(a[f]);b.recver(d,e,c)}c=a[a.length-1];a=[c]}};Microsoft.Live.Channels.Mux.register_recver=function(e,a,b,d){Microsoft.Live.Channels.Mux._useOldChannel=d?null:true;var c=null;if(b)c=function(c,d,e){var a=Microsoft.Live.Channels.Internal.decodeArgs(e);if(Microsoft.Live.Channels.Mux._useOldChannel){a.unshift(d);a.unshift(c);b.apply(this,a)}else b.apply(this,a)};a=a+"#"+e+"/";if("undefined"==typeof Microsoft.Live.Channels.Mux._receivers[a])Microsoft.Live.Channels.Mux._receivers[a]=new Microsoft.Live.Channels.Mux._Receiver(a);Microsoft.Live.Channels.Mux._receivers[a].recver=c;Microsoft.Live.Channels.Mux._receivers[a]._recv()};Microsoft.Live.Channels.Mux.init_iframes=function(){var a=document.getElementById("Microsoft.Live.Channels.Mux.Sframe");if(!a){a=document.createElement("iframe");a.id="Microsoft.Live.Channels.Mux.Sframe";a.style.width="0px";a.style.height="0px";a.style.visibility="hidden";document.body.appendChild(a)}var b=document.getElementById("Microsoft.Live.Channels.Mux.Rframe");if(!b){var b=document.createElement("iframe");b.id="Microsoft.Live.Channels.Mux.Rframe";b.style.width="0px";b.style.height="0px";b.style.visibility="hidden";document.body.appendChild(b)}};Microsoft.Live.Channels.Mux.register_iframe=function(){Microsoft.Live.Channels.Mux._useOldChannel=true;Microsoft.Live.Channels.Mux.init_iframes()};Microsoft.Live.Channels.Internal.getDomainFromURL=function(b){var a=null;if(b){a=b.split("/")[2];a=a.substr(a.indexOf("@")+1);if(a.indexOf(":")>0)a=a.substr(0,a.indexOf(":"))}return a};Microsoft.Live.Channels.Internal.encodeArgs=function(c){var b=[],a;for(a=0;a<c.length;a++){b[a]=encodeURIComponent(c[a]);b[a]=b[a].replace(new RegExp("'","g"),"%27")}return b.join("&")};Microsoft.Live.Channels.Internal.decodeArgs=function(c){var a=c.split("&");for(var b=0;b<a.length;b++){a[b]=a[b].replace(new RegExp("%27","g"),"'");a[b]=decodeURIComponent(a[b])}return a};Microsoft.Live.Channels.Channel=function(u,v,s){var a=this,m=4095;if(0<=navigator.userAgent.indexOf("Gecko/"))m=42263;var t="0123456789ABCDEF0123456789ABCDEF/C01234567/".length,g=1000,e=-1,w=v+"#"+u+"/",f,n=s,l,h=[],d,c,b=null,i=new OneShotSemaphore;Microsoft.Live.Channels.Mux._getUniqueId(function(b){e=b;Microsoft.Live.Channels.Mux._channels[b]=a;i.signal()});var j=function(){Microsoft.Live.Channels.Mux._send_chunk("S",c);b=window.setTimeout(o,g)},o=function(){Microsoft.Live.Channels.Mux._send_chunk("S",c);b=window.setTimeout(p,g*2)},p=function(){Microsoft.Live.Channels.Mux._send_chunk("S",c);b=window.setTimeout(q,g*3)},q=function(){Microsoft.Live.Channels.Mux._send_chunk("S",c);b=window.setTimeout(r,g*4)},r=function(){Microsoft.Live.Channels.Mux._clean_iframes("S");b=window.setTimeout(j,parseInt(g)/2)},k=function(){if(0==h.length)return;d++;var a=h[0],g=Math.min(l,a.length),b=a.substr(0,g);a=a.substr(g);if(0<a.length){h[0]=a;c=f+e+"/C"+d.toString(16)+"/"+b}else{h.shift();c=f+e+"/L"+d.toString(16)+"/"+b}j()};a.connect=function(a,b){i.waitFor(function(){f=b+"#"+a+"/";l=m-(f.length+t);d=0;var g=Microsoft.Live.Channels.Mux._encode(w);c=f+e+"/S"+d.toString(16)+"/"+g;j()})};a.send=function(){var a=Microsoft.Live.Channels.Internal.encodeArgs(arguments);Microsoft.Live.Channels.SendBytes+=a.length;Microsoft.Live.Channels.SendCounts++;i.waitFor(function(){a=Microsoft.Live.Channels.Mux._encode(a);h.push(a);if(null==b)k()})};a.abort=function(){};a._set_chanid=function(a){e=a;i.signal()};a._recv_chunk=function(c,a){if(e!=c||d!=a)return;clearTimeout(b);b=null;k()};a._validate_sender=function(c){var b=a.getCallerDomain();return c&&b&&c==b};a.getCallerDomain=function(){if(n)return n;else return Microsoft.Live.Channels.Internal.getDomainFromURL(f)}};Microsoft.Live.Channels.Internal.testFlashVersion=function(h,m){if(typeof Microsoft.Live.Channels.useFlashTransport!="undefined"&&!Microsoft.Live.Channels.useFlashTransport)return false;var b=0,d=0,k=navigator.appVersion.indexOf("MSIE")!=-1?true:false,i=navigator.appVersion.toLowerCase().indexOf("win")!=-1?true:false,g=navigator.userAgent.indexOf("Opera")!=-1?true:false;if(navigator.plugins!=null&&navigator.plugins.length>0){if(navigator.plugins["Shockwave Flash 2.0"]||navigator.plugins["Shockwave Flash"]){var e;if(navigator.plugins["Shockwave Flash 2.0"])e=navigator.plugins["Shockwave Flash 2.0"].description;else e=navigator.plugins["Shockwave Flash"].description;var l=e.split(" "),j=l[2].split(".");b=j[0];d=j[1]}}else if(k&&i&&!g){var a,f,p,c;try{f=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7");a=f.GetVariable("$version")}catch(q){}if(!a)try{f=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");a="WIN 6,0,21,0"}catch(q){}if(!a)return false;if(k&&i&&!g){var o=a.split(" "),n=o[1];c=n.split(",")}else c=a.split(".");b=c[0];d=c[1]}if(b==0)return false;if(b>parseFloat(h))return true;else if(b==parseFloat(h))if(d>=parseFloat(m))return true;return false};Microsoft.Live.Channels.Internal.getFlashControl=function(a){return document.getElementById(a)||document[a]};Microsoft.Live.Channels.Internal.trace=function(c){var a=document.getElementById("trace");if(a){var b=document.createElement("p");b.innerText=c;a.appendChild(b)}};Microsoft.Live.Channels.Internal.error=function(b){var a=Microsoft.Live.Channels.Internal.getFlashControl(p_id);if(a&&a.channel)a.channel.doError(b)};Microsoft.Live.Channels.FlashChannel=function(w,p,I){var d=this,a="",u=navigator.appVersion.indexOf("MSIE")!=-1?true:false,D=navigator.appVersion.toLowerCase().indexOf("win")!=-1?true:false,B=navigator.userAgent.indexOf("Opera")!=-1?true:false,J=function(c,b){var a=document.createElement("param");a.setAttribute("name",c);a.setAttribute("value",b);return a},z=function(){a=Microsoft.Live.Platform.uniqueID("IFM");var e="domain="+document.location.hostname,c=Microsoft.Live.Channels.secureScriptURL+"flashchannel.swf",b;b=document.createElement("div");b.id=a+"div";b.name=b.id;b.channel=d;window[a+"_DoFSCommand"]=function(d,c){var b=Microsoft.Live.Channels.Internal.getFlashControl(a+"div");switch(d){case "ready":if(b)G(b);break;case "listening":if(b)E(c=="true");break;case "dispatch":if(b)F(c);break;case "debug":Microsoft.Live.Channels.Internal.trace(c);break;case "error":if(b)y(c);break;case "setdomain":if(b)H(c)}};flashHTML="<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='https://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0' width = '1' height = '1' id = '"+a+"' type = 'application/x-shockwave-flash' data = '"+c+"'>"+"<param name= 'movie' value = '"+c+"'></param>"+"<param name='allowScriptAccess' value='always'></param> "+"<param name = 'FlashVars' value = '"+e+"'></param>"+"<embed play='true' menu='false' swLiveConnect='true' allowScriptAccess='always' type = 'application/x-shockwave-flash' FlashVars = '"+e+"' src='"+c+"' width = '1' height='1' name='"+a+"'></embed>"+"</object>";if(u)flashHTML+="<SCRIPT event='FSCommand(command,args)' for ='"+a+"' >"+a+"_DoFSCommand(command,args)</SCRIPT>";b.innerHTML=flashHTML;document.body.appendChild(b);return b};if(!u||!D||B)z();var t=null,v=false,b=null,c=null,e=w,n=false,m=false,k=0,h=[],i="",r=38*1024,j=null,A=-1,x=I,l=new OneShotSemaphore,C=new OneShotSemaphore;Microsoft.Live.Channels.Mux._getUniqueId(function(a){b=a;if(t)l.signal()});l.waitFor(function(){e=w;f("_Microsoft.Live.Channels.IFMConnect."+p,e);C.waitFor(function(){if(v){b="_Microsoft.Live.Channels.IFMConnect."+p;n=true;m=true}else{f(b,e);f(b+"ack",e);g("_Microsoft.Live.Channels.IFMConnect."+p,"#"+b);c="-"+b}})});d.send=function(){Microsoft.Live.Channels.SendCounts++;var a=Microsoft.Live.Channels.Internal.encodeArgs(arguments);h.push(a);Microsoft.Live.Channels.SendBytes+=a.length;if(!m&&c)l.waitFor(function(){if(!m&&j==null)q()})};d.getCallerDomain=function(){return x};var g=function(c,d){var b=document.embeds[a]||document.getElementById(a);if(b)b.SetVariable("ifm.SendParams","session="+encodeURIComponent(c)+"&arg="+encodeURIComponent(d))},f=function(d,c){var b=document.embeds[a]||document.getElementById(a);if(b)b.SetVariable("ifm.ListenParams","session="+encodeURIComponent(d)+"&arg="+encodeURIComponent(c))},s=function(c){var b=document.embeds[a]||document.getElementById(a);if(b)b.SetVariable("ifm.CloseParams","session="+encodeURIComponent(c))},o=function(a,b){g(a,b);j=setTimeout(function(){o(a,b)},1000)},q=function(){if(0==h.length){m=false;return}var a=h[0];k++;if(a.length>r){var b=a.substr(0,r);h[0]=a.substr(r);o(c,"C"+k+":"+b)}else{h.shift();o(c,"L"+k+":"+a)}},G=function(a){if(!t){t=a;if(b)l.signal()}},E=function(a){v=a;C.signal()},F=function(a){switch(a.charAt(0)){case "#":if(n){n=false;s(b);c=a.substr(1);b="-"+c;f(b,e);f(b+"ack",e);g(c,"AA");q()}break;case "C":if(d.onReceiveMessage){var h=a.indexOf(":");if(h>0){var l=a.substr(1,h-1);i+=a.substr(h+1);g(c+"ack","A"+l)}}break;case "L":if(d.onReceiveMessage){var h=a.indexOf(":");if(h>0){var l=a.substr(1,h-1);i+=a.substr(h+1);var m=Microsoft.Live.Channels.Internal.decodeArgs(i);i="";g(c+"ack","A"+l);if(A<parseInt(l)){d.onReceiveMessage.apply(d,m);A=parseInt(l)}}}break;case "A":if(parseInt(a.substr(1))==k||a.length==2&&a.charAt(1)=="A"){clearTimeout(j);j=null;q()}}},H=function(a){if(x!=a){d.send=function(){};s(b);s(c);y("The domain used for this connection is incorrect.")}},y=function(a){if(d.onError)d.onError(a)};if(u&&D&&!B)z()};registerNamespace("Microsoft.Live.Contacts.Write");Microsoft.Live.Contacts.Write.baseURL=window.location.protocol+"//controls.services.live.com/scripts/contacts/v0.3/";Microsoft.Live.Contacts.Write.scriptURL=Microsoft.Live.Contacts.Write.baseURL;Microsoft.Live.Contacts.Write=function(o,n,l){var m=this,b=[],c=0,e={"firstname":"Profile.Personal.FirstName","middlename":"Profile.Personal.MiddleName","lastname":"Profile.Personal.LastName","nickname":"Profile.Personal.NickName","emailpersonal":"Email.Personal.Address","emailbusiness":"Email.Business.Address","emailother":"Email.Other.Address","phonepersonal":"Phone.Personal.Number","phonebusiness":"Phone.Business.Number","phonemobile":"Phone.Mobile.Number","phonepager":"Phone.Pager.Number","phonefax":"Phone.Fax.Number","phoneother":"Phone.Other.Number","personalstreet":"Location.Personal.StreetLine","personalcity":"Location.Personal.PrimaryCity","personalstate":"Location.Personal.Subdivision","personalcountry":"Location.Personal.CountryRegion","personalpostalcode":"Location.Personal.PostalCode","businessname":"Location.Business.CompanyName","businessstreet":"Location.Business.StreetLine","businesscity":"Location.Business.PrimaryCity","businessstate":"Location.Business.Subdivision","businesscountry":"Location.Business.CountryRegion","businesspostalcode":"Location.Business.PostalCode","websitepersonal":"URI.Personal.Address","websitebusiness":"URI.Business.Address"},h={};for(var f in e)h[f]=f;var a=null,d=false;function j(c,g,a){var f="",d="";if(a instanceof Array)throw new Microsoft.Live.ArgumentException(L_79_T.replace("%1","fieldMap"));if(!a)a=h;for(var b in a)if(e[b]){if(c[a[b]]&&"function"!=typeof c[a[b]]){f+=d+encodeURIComponent(e[b])+"="+encodeURIComponent(c[a[b]]);d=g}}else throw new Microsoft.Live.ArgumentException(L_78_T.replace("%1",b));return f}function g(a){if(a>30)throw new Microsoft.Live.InvalidOperationException(L_7A_T);if(a+c>1000)throw new Microsoft.Live.InvalidOperationException(L_7B_T)}function k(f,a,h){if("undefined"===typeof a||a===null)throw new Microsoft.Live.ArgumentException(L_77_T.replace("%1","contacts"));if(!(a instanceof Array))throw new Microsoft.Live.ArgumentException(L_79_T.replace("%1","contacts"));g(a.length);var e=[encodeURIComponent(f)];for(var d=0;d<a.length;d++)e.push(j(a[d],"&",h));b.push(e.join(","));c+=a.length}this.callBack=null;this.createContacts=function(a,b){k("ADDCONTACTS",a,b)};this.deleteContacts=function(a){if("undefined"===typeof a||a===null)throw new Microsoft.Live.ArgumentException(L_77_T.replace("%1","contacts"));if(!(a instanceof Array))throw new Microsoft.Live.ArgumentException(L_79_T.replace("%1","contacts"));g(a.length);var d=encodeURIComponent("DELETECONTACTS");for(var e in a)d+=","+encodeURIComponent(a[e]);b.push(d);c+=a.length};this.commitContacts=function(c){if(d)throw new Microsoft.Live.InvalidOperationException(L_7C_T);if("undefined"===typeof c||c===null)throw new Microsoft.Live.ArgumentException(L_77_T.replace("%1","resultsCallback"));if(!("function"===typeof c))throw new Microsoft.Live.ArgumentException(L_79_T.replace("%1","resultsCallback"));if("undefined"===typeof a||a===null){a=document.getElementById(l);if(a&&a.channel)a=a.channel}if(0!=b.length){var e=encodeURIComponent("COMMIT")+"&&&"+b.join("&&");m.callBack=function(a){d=false;c(a)};a.send(e);i();d=true}else throw new Microsoft.Live.InvalidOperationException(L_7D_T)};var i=function(){b=null;b=[];c=0};this.abortContacts=function(){i()}};registerNamespace("Microsoft.Live.Intl");Microsoft.Live.Intl.baseURL=Microsoft.Live.Platform.expandURL(Microsoft.Live.Platform.baseURL,"../../intl/v0.3/");Microsoft.Live.Intl.scriptURL=Microsoft.Live.Platform.expandURL(Microsoft.Live.Platform.scriptURL,"../../intl/v0.3/");Microsoft.Live.Intl.computeMarket=function(c){var a=c.appPref||c.userPref||"en-us",d=Microsoft.Live.Intl.getCountry(a);if(!d||d.length==0){var b=Microsoft.Live.Intl.getLanguage(a);switch(b){case "en":a="en-us";break;case "ja":a="ja-jp";break;case "jp":a="ja-jp";break;case "ko":a="ko-kr";break;case "zh":a="zh-cn";break;default:a=b+"-"+b}}return a};Microsoft.Live.Intl.getLanguage=function(a){return a==null?null:a.substr(0,2)};Microsoft.Live.Intl.getCountry=function(a){return a==null?null:a.substr(3,2)};Microsoft.Live.Intl.getMarket=function(a,b){return a.substr(0,2)+"-"+b.substr(0,2)};Microsoft.Live.Intl.getLCID=function(b){var a={"en":1033,"en-us":1033,"fr":1036,"fr-fr":1036,"fr-ca":3084,"ja":1041,"jp":1041,"ja-jp":1041,"de":1031,"de-de":1031,"es":1034,"es-es":1034,"it":1040,"it-it":1040,"ko":1042,"ko-kr":1042,"nl":1043,"nl-nl":1043,"pt-br":1046,"sv":1053,"sv-se":1053,"zh-cn":2052};if(a[b])return a[b];else if(a[Microsoft.Live.Intl.getLanguage(b)])return a[Microsoft.Live.Intl.getLanguage(b)];else return a["en-us"]};Microsoft.Live.Intl.sanitizeMarket=function(a){if(!a||a.length==0)return "en-us";if(a.length<=2)return a;if(a.length>5||a.charAt(2)!="-")return "en-us";return a};Microsoft.Live.Intl.loadStrings=function(d){var c=d.market||"en-us",g=d.baseURL||"",f=d.filename||"strings.js",e=d.onCompletion||null,h=d.onError||null;c=Microsoft.Live.Intl.sanitizeMarket(c);var b=new XMLHttpRequest;try{b.open("GET",Microsoft.Live.Platform.expandURL(g,c+"/"+f),false);b.send("");if(b.status==200){var a=document.createElement("script");if(typeof a.canHaveChildren=="undefined"||a.canHaveChildren)a.appendChild(document.createTextNode(b.responseText));else a.text=b.responseText;var i=document.getElementsByTagName("head")[0];if(i)i.appendChild(a);else document.body.appendChild(a);if(e)e()}else if(h)h("ERROR")}catch(j){Microsoft.Live.Platform.load([Microsoft.Live.Platform.expandURL(g,Microsoft.Live.Intl.getLanguage(c)+"/"+f),Microsoft.Live.Platform.expandURL(g,c+"/"+f)],e)}};