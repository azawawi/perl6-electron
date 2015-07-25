use Atom::Electron::JSONBridged;

class Atom::Electron::BrowserWindow does Atom::Electron::JSONBridged {

  has Int $!width;
  has Int $!height;
  #has Bool $!dev_tools_enabled;
  #has Str $!url;
  #has Bool $!show;
  #has @!listeners;

  method new(Int $width, Int $height) {
      my $r = self.bless(:$width, :$height);
      Atom::Electron::JSONBridged.call_js('new', 1); # , width => $!width, height => $!height)
      $r;
  }
  #submethod BUILD($width, $height) {
  #    say "BrowserWindow.BUILD";
      #Atom::Electron::JSONBridged.call_js('new', 1); # , width => $!width, height => $!height);
  #}

	method on($event_name, $listener) {
		say "BrowserWindow.on...";

		#add-listener($event-name, $listener);
	}

	submethod add-listener($event-name, $listener) {
		#@!listeners.push($event-name);
	}

	method load_url(Str $url) {
		#Atom::Electron::JSONBridged.call_js('BrowserWindow-load_url', :url($url));
	}

	method show {
		#Atom::Electron::JSONBridged.call_js('BrowserWindow-show');
	}

}
