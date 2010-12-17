package MT::Plugin::WhileTag;

use strict;
use MT::Plugin;
use base qw( MT::Plugin );
use WhileTag::Util;

use vars qw($PLUGIN_NAME $VERSION);
$PLUGIN_NAME = 'WhileTag';
$VERSION = '0.01';

use MT;
my $plugin = MT::Plugin::WhileTag->new({
    id => 'whiletag',
    key => __PACKAGE__,
    name => $PLUGIN_NAME,
    version => $VERSION,
    description => "<MT_TRANS phrase='description of WhileTag'>",
    doc_link => 'mt-plugins/mt-while_tag/docs/mt-while_tag.html',
    author_name => 'ENDO Katsuhiro',
    author_link => 'http://github.com/ka2hiro',
    l10n_class => 'WhileTag::L10N',
    registry => {
        tags => {
            block => {
                'While' => \&hdlr_while,
            },
        },
    },
});

MT->add_plugin($plugin);

sub instance { $plugin; }

#----- Tags
sub hdlr_while {
    my ($ctx, $args, $cond) = @_;
    my $builder = $ctx->stash('builder');
    my $tokens = $ctx->stash('tokens');
    my $out = '';
    my $i = 1;
    my $glue = $args->{glue};
    while($ctx->tag('if', $args, $cond)) {
        my $res = $builder->build($ctx, $tokens, $cond);
        return $ctx->error($ctx->errstr) unless defined $res;
        if($res ne '') {
            $out .= $glue if defined $glue && $i > 1 && length($out) && length($res);
            $out .= $res;
            $i++;
        }
    }
    return $out;
}

1;
__END__
