
use strict;
use Irssi;
use Irssi::TextUI;
use vars qw($VERSION %IRSSI);

$VERSION = "0.1.1";


Irssi::statusbar_item_register('awaybar', 0, 'awaybar');
Irssi::signal_add('away mode changed', 'awaybar_redraw');


sub awaybar {
    my ($item, $get_size_only) = @_;
    my $away_reason = !Irssi::active_server() ? undef : Irssi::active_server()->{away_reason};

    if (defined $away_reason && length $away_reason) {
        my %r = ('\{' => '(',
                 '\}' => ')',
                 '%' => '%%',);
        $away_reason =~ s/$_/$r{$_}/g for (keys %r);

        #my $format = $theme->format_expand("{sb_awaybar $away_reason}");
        my $format = " {sb away: %G$away_reason}";

        $item->{min_size} = $item->{max_size} = length($away_reason);
        $item->default_handler($get_size_only, $format, 0, 1);
    } else {
        $item->{min_size} = $item->{max_size} = 0;
    }
}

sub awaybar_redraw {
    Irssi::statusbar_items_redraw('awaybar');
}
