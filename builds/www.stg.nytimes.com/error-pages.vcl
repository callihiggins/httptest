/*
 * These subs should synth static error pages
 * putting them here to keep this HTML out of the other files
 */

 sub render_50x_page {
 	synthetic {" <!DOCTYPE html><!--[if (gt IE 9)|!(IE)]><!--><html lang="en" class="no-js "  itemscope xmlns:og="http://opengraphprotocol.org/schema/"><!--<![endif]--><!--[if IE 9]><html lang="en" class="no-js ie9 lt-ie10 " xmlns:og="http://opengraphprotocol.org/schema/"><![endif]--><!--[if IE 8]><html lang="en" class="no-js ie8 lt-ie10 lt-ie9 " xmlns:og="http://opengraphprotocol.org/schema/"><![endif]--><!--[if (lt IE 8)]><html lang="en" class="no-js lt-ie10 lt-ie9 lt-ie8 " xmlns:og="http://opengraphprotocol.org/schema/"><![endif]--><head><title>Error</title><meta name="errorpage" content="true" /><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" /><script type="text/javascript">window.NREUM||(NREUM={}),__nr_require=function(t,e,n){function r(n){if(!e[n]){var o=e[n]={exports:{}};t[n][0].call(o.exports,function(e){var o=t[n][1][e];return r(o||e)},o,o.exports)}return e[n].exports}if("function"==typeof __nr_require)return __nr_require;for(var o=0;o<n.length;o++)r(n[o]);return r}({1:[function(t,e,n){function r(){}function o(t,e,n){return function(){return i(t,[(new Date).getTime()].concat(u(arguments)),e?null:this,n),e?void 0:this}}var i=t("handle"),a=t(2),u=t(3),c=t("ee").get("tracer"),f=NREUM;"undefined"==typeof window.newrelic&&(newrelic=f);var s=["setPageViewName","setCustomAttribute","finished","addToTrace","inlineHit"],p="api-",l=p+"ixn-";a(s,function(t,e){f[e]=o(p+e,!0,"api")}),f.addPageAction=o(p+"addPageAction",!0),e.exports=newrelic,f.interaction=function(){return(new r).get()};var d=r.prototype={createTracer:function(t,e){var n={},r=this,o="function"==typeof e;return i(l+"tracer",[Date.now(),t,n],r),function(){if(c.emit((o?"":"no-")+"fn-start",[Date.now(),r,o],n),o)try{return e.apply(this,arguments)}finally{c.emit("fn-end",[Date.now()],n)}}}};a("setName,setAttribute,save,ignore,onEnd,getContext,end,get".split(","),function(t,e){d[e]=o(l+e)}),newrelic.noticeError=function(t){ "string"==typeof t&&(t=new Error(t)),i("err",[t,(new Date).getTime()])}},{}],2:[function(t,e,n){function r(t,e){var n=[],r="",i=0;for(r in t)o.call(t,r)&&(n[i]=e(r,t[r]),i+=1);return n}var o=Object.prototype.hasOwnProperty;e.exports=r},{}],3:[function(t,e,n){function r(t,e,n){e||(e=0),"undefined"==typeof n&&(n=t?t.length:0);for(var r=-1,o=n-e||0,i=Array(o<0?0:o);++r<o;)i[r]=t[e+r];return i}e.exports=r},{}],ee:[function(t,e,n){function r(){}function o(t){function e(t){return t&&t instanceof r?t:t?u(t,a,i):i()}function n(n,r,o){t&&t(n,r,o);for(var i=e(o),a=l(n),u=a.length,c=0;c<u;c++)a[c].apply(i,r);var s=f[m[n]];return s&&s.push([w,n,r,i]),i}function p(t,e){g[t]=l(t).concat(e)}function l(t){return g[t]||[]}function d(t){return s[t]=s[t]||o(n)}function v(t,e){c(t,function(t,n){e=e||"feature",m[n]=e,e in f||(f[e]=[])})}var g={},m={},w={on:p,emit:n,get:d,listeners:l,context:e,buffer:v};return w}function i(){return new r}var a="nr@context",u=t("gos"),c=t(2),f={},s={},p=e.exports=o();p.backlog=f},{}],gos:[function(t,e,n){function r(t,e,n){if(o.call(t,e))return t[e];var r=n();if(Object.defineProperty&&Object.keys)try{return Object.defineProperty(t,e,{value:r,writable:!0,enumerable:!1}),r}catch(i){}return t[e]=r,r}var o=Object.prototype.hasOwnProperty;e.exports=r},{}],handle:[function(t,e,n){function r(t,e,n,r){o.buffer([t],r),o.emit(t,e,n)}var o=t("ee").get("handle");e.exports=r,r.ee=o},{}],id:[function(t,e,n){function r(t){var e=typeof t;return!t||"object"!==e&&"function"!==e?-1:t===window?0:a(t,i,function(){return o++})}var o=1,i="nr@id",a=t("gos");e.exports=r},{}],loader:[function(t,e,n){function r(){if(!h++){var t=y.info=NREUM.info,e=s.getElementsByTagName("script")[0];if(t&&t.licenseKey&&t.applicationID&&e){c(m,function(e,n){t[e]||(t[e]=n)});var n="https"===g.split(":")[0]||t.sslForHttp;y.proto=n?"https://":"http://",u("mark",["onload",a()],null,"api");var r=s.createElement("script");r.src=y.proto+t.agent,e.parentNode.insertBefore(r,e)}}}function o(){ "complete"===s.readyState&&i()}function i(){u("mark",["domContent",a()],null,"api")}function a(){return(new Date).getTime()}var u=t("handle"),c=t(2),f=window,s=f.document,p="addEventListener",l="attachEvent",d=f.XMLHttpRequest,v=d&&d.prototype;NREUM.o={ST:setTimeout,CT:clearTimeout,XHR:d,REQ:f.Request,EV:f.Event,PR:f.Promise,MO:f.MutationObserver},t(1);var g=""+location,m={beacon:"bam.nr-data.net",errorBeacon:"bam.nr-data.net",agent:"js-agent.newrelic.com/nr-963.min.js" },w=d&&v&&v[p]&&!/CriOS/.test(navigator.userAgent),y=e.exports={offset:a(),origin:g,features:{},xhrWrappable:w};s[p]?(s[p]("DOMContentLoaded",i,!1),f[p]("load",r,!1)):(s[l]("onreadystatechange",o),f[l]("onload",r)),u("mark",["firstbyte",a()],null,"api");var h=0},{}]},{},["loader"]);</script><meta name="sourceApp" content="nyt-v5" /><meta id="foundation-build-id" name="foundation-build-id" content="" /><meta name="errortype" content="500 - Server Error" /><meta name="PST" content="" /><!--[if (gt IE 9)|!(IE)]><!--><link rel="stylesheet" type="text/css" media="screen" href="https://a1.nyt.com/assets/error/latest/css/error/styles.css" /><!--<![endif]--><!--[if lte IE 9]><link rel="stylesheet" type="text/css" media="screen" href="https://a1.nyt.com/assets/error/latest/css/error/styles-ie.css" /><![endif]--><script>var require = {    baseUrl: 'https://a1.nyt.com/assets/',    waitSeconds: 20,    paths: {        //'foundation': 'error/latest/js/foundation',        //'shared': 'error/latest/js/shared',        //'error': 'error/latest/js/error'        //'application': 'error/latest/js/error/'    }};</script><!--[if (gte IE 9)|!(IE)]><!--><script data-main="foundation/main" src="https://a1.nyt.com/assets/error/latest/js/foundation/lib/framework.js"></script><!--<![endif]--><!--[if lt IE 9]><script>    require.map = { '*': { 'foundation/main': 'foundation/legacy_main' } };</script><script data-main="foundation/legacy_main" src="https://a1.nyt.com/assets/error/latest/js/foundation/lib/framework.js"></script><![endif]--><script>window.magnum.processFlags([]);</script></head><body><style>    .lt-ie10 .messenger.suggestions {        display: block !important;        height: 50px;    }    .lt-ie10 .messenger.suggestions .message-bed {        background-color: #f8e9d2;        border-bottom: 1px solid #ccc;    }    .lt-ie10 .messenger.suggestions .message-container {        padding: 11px 18px 11px 30px;    }    .lt-ie10 .messenger.suggestions .action-link {        font-family: "nyt-franklin", arial, helvetica, sans-serif;        font-size: 10px;        font-weight: bold;        color: #a81817;        text-transform: uppercase;    }    .lt-ie10 .messenger.suggestions .alert-icon {        background: url('https://static01.nyt.com/images/icons/icon-alert-12x12-a81817.png') no-repeat;        width: 12px;        height: 12px;        display: inline-block;        margin-top: -2px;        float: none;    }    .lt-ie10 .masthead,    .lt-ie10 .navigation,    .lt-ie10 .comments-panel {        margin-top: 50px !important;    }    .lt-ie10 .ribbon {        margin-top: 97px !important;    }</style><div id="suggestions" class="suggestions messenger nocontent robots-nocontent" style="display:none;"><div class="message-bed"><div class="message-container last-message-container"><div class="message"><span class="message-content"><i class="icon alert-icon"></i><span class="message-title">NYTimes.com no longer supports Internet Explorer 9 or earlier. Please upgrade your browser.</span><a href="http://www.nytimes.com/content/help/site/ie9-support.html" class="action-link">LEARN MORE &raquo</a></span></div></div></div></div><div id="shell" class="shell"><header id="masthead" class="masthead masthead-theme-standard" role="banner"><div class="container"><div class="quick-navigation button-group"><button class="button sections-button"><i class="icon sprite-icon"></i><span class="button-text">Sections</span></button><button class="button home-button" data-href="http://www.nytimes.com/" title="Go to the home page to see the latest top stories."><i class="icon sprite-icon"></i><span class="button-text">Home</span></button><button class="button search-button"><i class="icon sprite-icon"></i><span class="button-text">Search</span></button><a class="button skip-button skip-to-content visually-hidden focusable" href="#main">Skip to content</a></div><!-- close button-group --><div class="branding"><h2 class="branding-heading"><a id="branding-heading-link" href="http://www.nytimes.com/"><span class="visually-hidden">The New York Times</span></a></h2><script>window.magnum.writeLogo('small', 'https://a1.nyt.com/assets/error/latest/images/foundation/logos/', '', 'masthead-theme-standard', '', 'branding-heading-link', 'error');</script></div><!-- close branding --><div id="TopNavAd" class="ad top-nav-ad nocontent robots-nocontent"><div class="accessibility-ad-header visually-hidden"><p>Advertisement</p></div></div><div class="user-tools"><button class="button search-button"><i class="icon sprite-icon"></i><span class="button-text">Search</span></button><div id="Bar1" class="ad bar1-ad nocontent robots-nocontent"></div><div class="user-tools-button-group button-group"><button class="button subscribe-button hidden" data-href="http://www.nytimes.com/subscriptions/Multiproduct/lp3004.html?campaignId=4XUYF">Subscribe Now</button><button class="button login-button login-modal-trigger hidden">Log In</button><button class="button notifications-button hidden"><i class="icon sprite-icon"></i><span class="button-text">0</span></button><button class="button user-settings-button"><i class="icon sprite-icon"></i><span class="button-text">Settings</span></button></div><!-- close user-tools-button-group --></div><!-- close user-tools --></div><!-- close container --><div class="search-flyout-panel flyout-panel"><button class="button close-button" type="button"><i class="icon"></i><span class="visually-hidden">Close search</span></button><div class="ad"><div id="SponsorAd" class="sponsor-ad"><small class="ad-sponsor">search sponsored by</small></div></div><nav class="search-form-control form-control layout-horizontal"><h2 class="visually-hidden">Site Search Navigation</h2><form class="search-form" role="search"><div class="control"><div class="label-container visually-hidden"><label for="search-input-2">Search NYTimes.com</label></div><div class="field-container"><input id="search-input-2" name="search-input-2" type="text" class="search-input text" autocomplete="off" placeholder="Search NYTimes.com" /><button type="button" class="button clear-button" tabindex="-1" aria-describedby="clear-search-input"><i class="icon"></i><span id="clear-search-input" class="visually-hidden">Clear this text input</span></button><div class="auto-suggest" style="display: none;"><ol></ol></div><button class="button submit-button" type="submit">Go</button></div></div><!-- close control --></form></nav></div><!-- close flyout-panel --><div id="notification-modals" class="notification-modals"></div></header><nav id="navigation" class="navigation"><h2 class="visually-hidden">Site Navigation</h2></nav><!-- close navigation --><nav id="mobile-navigation" class="mobile-navigation hidden"><h2 class="visually-hidden">Site Mobile Navigation</h2></nav><!-- close mobile-navigation --><div id="navigation-edge" class="navigation-edge"></div><div id="page" class="page"><main id="main" class="main" role="main"><article class="error-page"><header class="error-header"><h1>Server Error</h1><h2>We're sorry. there is a problem with the page you requested.<br>We are investigating the error, please try again soon.</h2></header><nav class="search-form-control form-control layout-horizontal"><h2 class="visually-hidden">Site Search Navigation</h2><form class="search-form" role="search"><div class="control"><div class="label-container visually-hidden"><label for="search-input-2">Search NYTimes.com</label></div><div class="field-container"><input id="search-input-2" name="search-input-2" type="text" class="search-input text" autocomplete="off" placeholder="Search NYTimes.com" /><button type="button" class="button clear-button" tabindex="-1" aria-describedby="clear-search-input"><i class="icon"></i><span id="clear-search-input" class="visually-hidden">Clear this text input</span></button><div class="auto-suggest" style="display: none;"><ol></ol></div><button class="button submit-button" type="submit">Go</button></div></div><!-- close control --></form></nav><ul class="menu layout-horizontal theme-links with-pipes"><li><a href="https://myaccount.nytimes.com/membercenter/feedback.html">Report a broken link</a></li><li><a href="/">Go to Home Page</a></li></ul></article><div class="search-overlay"></div></main><!-- close main --><section id="site-index" class="site-index"><header class="section-header"><p class="user-action"><a href="http://www.nytimes.com/">Go to Home Page &raquo;</a></p><h2 class="section-heading"><span class="visually-hidden">Site Index</span><a id="site-index-branding-link" href="http://www.nytimes.com/"><span class="visually-hidden">The New York Times</span></a></h2><script>window.magnum.writeLogo('small', 'https://a1.nyt.com/assets/error/latest/images/foundation/logos/', '', '', '', 'site-index-branding-link', '');</script></header></section><!-- close site-index --><footer id="page-footer" class="page-footer" role="contentinfo"><nav><h2 class="visually-hidden">Site Information Navigation</h2><ul><li><a href="http://www.nytimes.com/content/help/rights/copyright/copyright-notice.html" itemprop="copyrightNotice">                    &copy; <span itemprop="copyrightYear">2016</span><span itemprop="copyrightHolder provider sourceOrganization" itemscope itemtype="http://schema.org/Organization" itemid="http://www.nytimes.com"><span itemprop="name"> The New York Times Company</span><meta itemprop="tickerSymbol" content="NYSE NYT"/></span></a></li><li class="visually-hidden"><a href="http://www.nytimes.com">Home</a></li><li class="visually-hidden"><a href="http://query.nytimes.com/search/sitesearch/#/">Search</a></li><li class="visually-hidden">Accessibility concerns? Email us at <a href="mailto:accessibility@nytimes.com">accessibility@nytimes.com</a>. We would love to hear from you.</li><li class="wide-viewport-item"><a href="http://www.nytimes.com/ref/membercenter/help/infoservdirectory.html">Contact Us</a></li><li class="wide-viewport-item"><a href="http://www.nytco.com/careers">Work With Us</a></li><li class="wide-viewport-item"><a href="http://www.nytimes.whsites.net/mediakit">Advertise</a></li><li class="wide-viewport-item"><a href="http://www.nytimes.com/content/help/rights/privacy/policy/privacy-policy.html#pp">Your Ad Choices</a></li><li><a href="http://www.nytimes.com/privacy">Privacy</a></li><li><a href="http://www.nytimes.com/ref/membercenter/help/agree.html" itemprop="usageTerms">Terms of Service</a></li><li class="wide-viewport-item last-item"><a href="http://www.nytimes.com/content/help/rights/sale/terms-of-sale.html">Terms of Sale</a></li></ul></nav><nav class="last-nav"><h2 class="visually-hidden">Site Information Navigation</h2><ul><li><a href="http://spiderbites.nytimes.com">Site Map</a></li><li><a href="http://www.nytimes.com/membercenter/sitehelp.html">Help</a></li><li><a href="https://myaccount.nytimes.com/membercenter/feedback.html">Site Feedback</a></li><li class="wide-viewport-item last-item"><a href="http://www.nytimes.com/subscriptions/Multiproduct/lp5558.html?campaignId=37WXW">Subscriptions</a></li></ul></nav></footer></div><!-- close page --></div><!-- close shell --><script>require(['foundation/main'], function () {    require(['error/main']);    require(['jquery/nyt', 'foundation/views/page-manager'], function ($, pageManager) {        if (window.location.search.indexOf('disable_tagx') > 0) {            return;        }        $(document).ready(function () {            require(['https://a1.nyt.com/analytics/tagx-simple.min.js'], function () {                pageManager.trackingFireEventQueue();            });        });    });});</script><script type="text/javascript">window.NREUM||(NREUM={});NREUM.info={ "beacon":"bam.nr-data.net","licenseKey":"b5bcf2eba4","applicationID":"6021368","transactionName":"YwFXZhRYVhAEVUZcX1pLYEAPFlkTFRhCXUA=","queueTime":0,"applicationTime":13,"ttGuid":"","agentToken":"","userAttributes":"","errorBeacon":"bam.nr-data.net","agent":"" }</script></body></html> "};
 }