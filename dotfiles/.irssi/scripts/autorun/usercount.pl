
use Irssi 20020101.0250 ();
$VERSION = "1.16";

# Once you have loaded this script run the following command:
# /statusbar window add usercount
# You can also add -alignment left|right option

# /set usercount_show_zero on or off to show users when 0 users of that type
# /set usercount_show_ircops (default off)
# /set usercount_show_halfops (default on)

# you can customize the look of this item from theme file:
#  sb_usercount = "{sb %_$0%_ nicks ($1-)}";
#  sb_uc_ircops = "%_*%_$*";
#  sb_uc_ops = "%_@%_$*";
#  sb_uc_halfops = "%_%%%_$*";
#  sb_uc_voices = "%_+%_$*";
#  sb_uc_normal = "$*";
#  sb_uc_space = " ";


use strict;
use Irssi::TextUI;

my ($ircops, $ops, $halfops, $voices, $normal, $total);
my ($timeout_tag, $recalc);

# Called to make the status bar item
sub usercount {
  my ($item, $get_size_only) = @_;
  my $wi = !Irssi::active_win() ? undef : Irssi::active_win()->{active};

  if(!ref $wi || $wi->{type} ne "CHANNEL") { # only works on channels
    return unless ref $item;
    $item->{min_size} = $item->{max_size} = 0;
    return;
  }

  if ($recalc) {
    $recalc = 0;
    calc_users($wi);
  }

  my $theme = Irssi::current_theme();
  my $format = $theme->format_expand("{sb_usercount}");


    # use the default look
    $format = " %C{sb %G$total %cnicks %C(";
    $format .= '%6%k*%n%G'.$ircops.' ' if (defined $ircops);
    $format .= '%6%k@%n%G'.$ops.' ' if (defined $ops);
    $format .= '%6%k%%%n%G'.$halfops.' ' if (defined $halfops);
    $format .= '%6%k+%n%G'.$voices.' ' if (defined $voices);
    $format .= '%6%k %n%G'.$normal if (defined $normal);
    $format =~ s/ $//;
    $format .= "%C)}";


  $item->default_handler($get_size_only, $format, undef, 1);
}

sub calc_users() {
  my $channel = shift;
  my $server = $channel->{server};

  $ircops = $ops = $halfops = $voices = $normal = 0;
  for ($channel->nicks()) {
    if ($_->{serverop}) {
      $ircops++;
	}

    if ($_->{op}) {
      $ops++;
	} elsif ($_->{halfop}) {
	   $halfops++;
    } elsif ($_->{voice}) {
      $voices++;
    } else {
      $normal++;
    }
  }

  $total = $ops+$halfops+$voices+$normal;
  if (!Irssi::settings_get_bool('usercount_show_zero')) {
    $ircops = undef if ($ircops == 0);
    $ops = undef if ($ops == 0);
    $halfops = undef if ($halfops == 0);
    $voices = undef if ($voices == 0);
    $normal = undef if ($normal == 0);
  }
  $halfops = undef unless Irssi::settings_get_bool('usercount_show_halfops');
  $ircops = undef unless Irssi::settings_get_bool('usercount_show_ircops');
}

sub refresh {
   if ($timeout_tag > 0) {
      Irssi::timeout_remove($timeout_tag);
      $timeout_tag = 0;
   }
   Irssi::statusbar_items_redraw('usercount');
}

sub refresh_check {
   my $channel = shift;
   my $wi = ref Irssi::active_win() ? Irssi::active_win()->{active} : 0;

   return unless ref $wi && ref $channel;
   return if $wi->{name} ne $channel->{name};
   return if $wi->{server}->{tag} ne $channel->{server}->{tag};

   # don't refresh immediately, or we'll end up refreshing
   # a lot around netsplits
   $recalc = 1;
   Irssi::timeout_remove($timeout_tag) if ($timeout_tag > 0);
   $timeout_tag = Irssi::timeout_add(500, 'refresh', undef);
}

sub refresh_recalc {
  $recalc = 1;
  refresh();
}

$recalc = 1;
$timeout_tag = 0;

Irssi::settings_add_bool('usercount', 'usercount_show_zero', 1);
Irssi::settings_add_bool('usercount', 'usercount_show_ircops', 1);
Irssi::settings_add_bool('usercount', 'usercount_show_halfops', 0);

Irssi::statusbar_item_register('usercount', undef, 'usercount');
Irssi::statusbars_recreate_items();

Irssi::signal_add_last('nicklist new', 'refresh_check');
Irssi::signal_add_last('nicklist remove', 'refresh_check');
Irssi::signal_add_last('nick mode changed', 'refresh_check');
Irssi::signal_add_last('setup changed', 'refresh_recalc');
Irssi::signal_add_last('window changed', 'refresh_recalc');
Irssi::signal_add_last('window item changed', 'refresh_recalc');

