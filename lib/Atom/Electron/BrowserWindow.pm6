class Atom::Electron::BrowserWindow does Atom::Electron::JSONBridge {

  use Atom::Electron::JSONBridge;

  has Int $!width;
  has Int $!height;
  has Bool $!dev_tools_enabled;
  has Str $!url;

  submethod BUILD(:$!width, :$!height, :$!show) {
        say "BrowserWindow.BUILD";
    }

	method on($event_name, $listener) {
		say "BrowserWindow.on...";

		add-listener($event-name, $listener);
	}

	submethod add-listener($event-name, $listener) {
		@!listeners.push($event-name);
	}

	method load_url(Str $url) {
		js-call('loadUrl', :instance($instanceId), :url($url));
	}

	method show {
		js-call('show', :instance($instanceId));
	}

}
