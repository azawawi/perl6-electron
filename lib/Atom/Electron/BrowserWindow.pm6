use Atom::Electron::JSONBridged;

class Atom::Electron::BrowserWindow does Atom::Electron::JSONBridged {

  has Int $!width;
  has Int $!height;
  has Bool $!dev_tools_enabled;
  has Str $!url;
  has Bool $!show;
  has @!listeners;

  submethod BUILD(:$!width, :$!height, :$!show) {
      say "BrowserWindow.BUILD";
      call_js('new', width => $!width, height => $!height);
  }

	method on($event_name, $listener) {
		say "BrowserWindow.on...";

		#add-listener($event-name, $listener);
	}

	submethod add-listener($event-name, $listener) {
		@!listeners.push($event-name);
	}

	method load_url(Str $url) {
		call_js('BrowserWindow-load_url', :url($url));
	}

	method show {
		call_js('BrowserWindow-show');
	}

}
