# $Id$

package WhileTag::Util;

use strict;
use base qw( Exporter );
our @EXPORT = qw( doLog is_mt4 is_mt41 is_mt42 is_mt5 );

sub doLog {
    my ($msg) = @_;
    return unless defined $msg;
    require MT::Log;
    my $log = MT::Log->new;
    $log->message($msg);
    $log->save or die $log->errstr;
    return;
}

sub is_mt4 {
    return (substr(MT->version_number, 0, 2) eq '4.');
}

sub is_mt41 {
    return (substr(MT->version_number, 0, 3) eq '4.1');
}

sub is_mt42 {
    return (substr(MT->version_number, 0, 3) eq '4.2');
}

sub is_mt5 {
    return (substr(MT->version_number, 0, 2) eq '5.');
}

1;