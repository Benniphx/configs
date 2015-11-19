# bitchx-like shitlist

# for irssi 0.7.98 (level 4 requires later)
# Copyright (C) 2001 Timo Sirainen 
# (partly based on friends.pl by Erkki Seppälä)
# shitlist exception channels patch by evilcat macova@raw.thesocket.net
# /SET dontshitchannels #channel1 #channel2  
# changed shitlist exception to be case insensitive by SinusPL admin@sinuspl.net
# improved message (now shows channel) by SinusPL admin@sinuspl.net

#  /ADDSHIT <nickmask> [<* | #chan1,#chan2,...> [shitlevel] [reason]]
#   shitlevel:
#     1 - Deop user
#     2 - Kick user
#     3 - Kickban user - DEFAULT
#     4 - Keep the user in permanent ban - NOTE: crashes in irssi 0.7.98.3 and older
#    - adds a new shitlist item

#  /DELSHIT <index#>
#    - removes a shitlist item

#  /SHITLIST
#    - displays the current shitlist

use strict;
use Irssi;
use Irssi::Irc;

Irssi::settings_add_str("misc", "dontshitchannels", "");
my @shitlist = ();
my $shit_file = "$ENV{HOME}/.irssi/shitlist";

Irssi::theme_register([
  'shitlist_add', '$0 added to shitlist',
  'shitlist_del', '$0 removed from shitlist',
  'shitlist_nosuchitem', 'No such item in shitlist',
  'shitlist_loaded', '',
  'shitlist_empty', 'Nothing in shitlist',
  'shitlist_header', ' # nickmask                 lvl channels   reason',
  'shitlist_line', '$[!-2]0 $[!26]1 $2 $[!10]3 $4'
]);

sub exec_shit {
  my ($server, $shit, $nick, $channel, $is_op) = @_;

  if ($shit->{level} == 1) {
    # deop user
    if ($is_op) {
      $server->command("mode $channel -o $nick");
    }
    return;
  }

  if ($shit->{level} == 2) {
    # kick user
    $server->command("kick $channel $nick ".$shit->{reason});
  }

  if ($shit->{level} == 3) {
    # kickban user
    # shasta@01/06/17: set ban using correct shitmask, not using 
    #                  current ban_type; also, check if we should
    #                  kick, or ban first (will work only with
    #                  irssi dated on 2001-05-12 and newer)
    if (Irssi::settings_get_bool("kick_first_on_kickban")) {
      $server->command("kick $channel $nick ".$shit->{reason});
      $server->command("ban $channel ".$shit->{nickmask});
    } else {
      $server->command("ban $channel ".$shit->{nickmask});
      $server->command("kick $channel $nick ".$shit->{reason});
    }
  }
};

sub check_shit {
  my ($server, $channel, $nick, $host, $is_op) = @_;
  my @noshit = split(/ /,Irssi::settings_get_str("dontshitchannels"));
  my $ignorechannel = '';
  my $ignorechannel_lowcase = '';
  my $channel_lowcase= '';
  my $ichanbool = "0";
  foreach my $shit (@shitlist) {
    if ((exists $shit->{channels}->{'*'} || 
	 exists $shit->{channels}->{$channel}) && 
	Irssi::mask_match_address($shit->{nickmask}, $nick, $host)) {
      # shasta@01/06/17: check if we are a chanop on $channel...
      my $chan = Irssi::channel_find($channel);
      if ($chan->{chanop}) { 
      # shasta@01/06/17: ... if so,
      # shit matches
foreach $ignorechannel (split / /, Irssi::settings_get_str("dontshitchannels")) 
{
	$channel_lowcase=$channel;
	$channel_lowcase=~tr/A-Z/a-z/;
	$ignorechannel_lowcase=$ignorechannel;
	$ignorechannel_lowcase=~tr/A-Z/a-z/;
	
 	if ( $ignorechannel_lowcase eq $channel_lowcase ) { $ichanbool = 1; }
}
if ( $ichanbool == 1 )  
{ 
	Irssi::print("Excluded channel $channel_lowcase, not kicking $nick, shit $host");
}
else 
{	
	Irssi::print("SHIT on channel $channel_lowcase, kicking $nick!$host");
	exec_shit($server, $shit, $nick, $channel, $is_op); 
}
      }
      last;
    }
  }
}

sub check_shit_permban {
  my ($shit, $channel) = @_;

  foreach my $ban ($channel->bans()) {
    return 0 if ($ban->{ban} eq $shit->{nickmask})
  }

  return 1;
}

sub event_join {
  my ($server, $data, $nick, $host) = @_;

  $data =~ s/^://;
  check_shit($server, $data, $nick, $host, 0) if ($nick ne $server->{nick});
}

sub check_channel_shit {
  my $channel = shift;

  # check if the channel contains any shitlist users
  my @nicks = $channel->nicks();
  foreach my $nick (@nicks) {
    check_shit($channel->{server}, $channel->{name},
               $nick->{nick}, $nick->{host}, $nick->{op})
      if ($nick->{nick} ne $channel->{server}->{nick});
  }

  # make sure the permanent bans are set
  my $bans = "";
  foreach my $shit (@shitlist) {
    if ($shit->{level} == 4 && (exists $shit->{channels}->{'*'} ||
				exists $shit->{channels}->{$channel})) {
      if (check_shit_permban($shit, $channel)) {
	# not in ban list
	$bans .= " ".$shit->{nickmask};
      }
    }
  }

  $channel->command("ban$bans") if ($bans ne "");
}

sub shitlist_check_all {
  foreach my $channel (Irssi::channels()) {
    check_channel_shit($channel) if ($channel->{chanop});
  }
}

sub sig_nick_mode_changed {
  my ($channel, $nick) = @_;

  return if (!$channel->{chanop});

  if ($nick->{nick} eq $channel->{server}->{nick}) {
    # we got ops
    check_channel_shit($channel);
  } elsif ($nick->{op}) {
    check_shit($channel->{server}, $channel->{name},
               $nick->{nick}, $nick->{host}, 1);
  }
}

# mask, level, reason, channel(s)
sub new_shit {
  my $shit = {};
  $shit->{nickmask} = shift;
  $shit->{level} = shift;
  $shit->{reason} = shift;
  for (my $c = 0; $c < @_; ++$c) {
    $shit->{channels}->{$_[$c]} = 1;
  }
  return $shit;
}

sub load_shitlist {
  @shitlist = ();
  if (-e $shit_file) {
    local *F;
    open(F, "<$shit_file");
    local $/ = "\n";
    while (<F>) {
      chop;
      my $new_shit = new_shit(split("\t"));
      if ($new_shit->{nickmask} ne "") {
 	push(@shitlist, $new_shit);
      } else {
	Irssi::print("Skipping $new_shit", MSGLEVEL_CLIENTERROR);
      }
    }
    close(F);
  }
  Irssi::printformat(MSGLEVEL_CLIENTNOTICE, 'shitlist_loaded', 
                     $shit_file, scalar(@shitlist));
}

sub get_shit_channels {
  return keys(%{$_[0]->{channels}});
}

sub save_shitlist {
  local *F;
  open(F, ">$shit_file") or die "Couldn't open file for writing";

  for (my $c = 0; $c < @shitlist; ++$c) {
    print(F join("\t", $shitlist[$c]->{nickmask}, $shitlist[$c]->{level},
                 $shitlist[$c]->{reason}, 
		 get_shit_channels($shitlist[$c])) . "\n");
  }
  close(F);
}

# /ADDSHIT <nickmask> [<* | #chan1,#chan2,...> [shitlevel] [reason]]]
sub cmd_addshit {
  my $data = shift;

  my ($nickmask, $channels, $shitlevel, $reason) = split (" ", $data, 4);

  if ($nickmask eq "") {
    Irssi::print('Not enough arguments. Usage: /ADDSHIT <nickmask> [<* | #chan1,#chan2,...> [shitlevel] [reason]]]');
    return;
  }

  $channels = "*" if ($channels eq "");

  if ($shitlevel !~ /^[1-4]$/) {
    if ($shitlevel ne "") {
      if ($reason eq "") {
	$reason = $shitlevel;
      } else {
	$reason = "$shitlevel $reason";
      }
    }
    $shitlevel = 3;
  }

  push(@shitlist, new_shit($nickmask, $shitlevel, $reason, split(",", $channels)));
  Irssi::printformat(MSGLEVEL_CLIENTNOTICE, 'shitlist_add', $nickmask);
  save_shitlist();

  # check if the new shitlist matches in any of the channels
  shitlist_check_all();
}

sub cmd_delshit {
  my ($index) = split(" ", $_[0], 1);
  my $shit = splice(@shitlist, $index, 1);
  if ($shit) {
    Irssi::printformat(MSGLEVEL_CLIENTNOTICE, 'shitlist_del', 
                        $shit->{nickmask});
    save_shitlist();
  } else {
    Irssi::printformat(MSGLEVEL_CLIENTNOTICE, 'shitlist_nosuchitem');
  }
}

sub cmd_shitlist {
  if (@shitlist == 0) {
    Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'shitlist_empty');
  } else {
    Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'shitlist_header');
    for (my $c = 0; $c < @shitlist ; ++$c) {
      Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'shitlist_line', 
                $c, $shitlist[$c]->{nickmask},
		$shitlist[$c]->{level},
		join(",", get_shit_channels($shitlist[$c])),
		$shitlist[$c]->{reason});
    }
  }
}

load_shitlist();
shitlist_check_all();

Irssi::signal_add_last('event join', 'event_join'); # last so that /KICKBAN gets to know the nick host and it can ban it
Irssi::signal_add('nick mode changed', 'sig_nick_mode_changed');

Irssi::command_bind('addshit', 'cmd_addshit');
Irssi::command_bind('delshit', 'cmd_delshit');
Irssi::command_bind('unshit', 'cmd_delshit');
Irssi::command_bind('shitlist', 'cmd_shitlist');
