# statsd-jsonp

Created by Roger Jungemann

Perhaps you want to gather metrics for your web application directly from JavaScript. <a href="https://github.com/etsy/statsd">Statsd</a> is a wonderful way to aggregate statistics in order to pass them onto a service like <a href="http://librato.com">Librato</a> or to a self-hosted solution like <a href="http://graphite.wikidot.com">Graphite</a>.

However, getting statistics from the front-end to statsd is difficult for 2 reasons:

* Statsd requires data to be sent over UDP.
* JavaScript doesn't let you make requests to servers on other domains unless you use something like JSONP.

This project allows you to make JSONP requests to a middleman endpoint (which may live on another domain) which will ferry requests to statsd for you.

## Getting Started

For our purposes it is simplest to try this out locally first.

* Setup statsd locally on port 8125.
* From one Terminal window, run `rake run` to start the middleman
* From another Terminal window, run `rake sample:run` to start a sample web application
* From a third Terminal window, run `rake sample:open` to open the sample web application in the browser
* Click the "Report" link and review output in:
	* The JavaScript console in the browser
	* The standard output from the statsd-jsnp middleman
	* The standard output from statsd

## Usage

* Use a `<script>` tag to include the `statsd-jsonp.js` file in your HTML file
* Call `$.statsd.report()`. You can pass a hash containing arguments. All arguments are optional.
	* `endpoint` - Defaults to `'http://localhost:8124/'`
	* `method` - Defaults to `'increment'`
	* `stat` - Defaults to `'bars'`
	* `value` - Defaults to `1`
	* `samplerate` - Defaults to `null`
	* `ajaxMethod` - Defaults to `'GET'`
	* `success` - Defaults to `(json) -> console.log 'success', json`
	* `error` - Defaults to `(e) -> console.log 'failure', e`

