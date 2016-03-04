package Dist::Zilla::Plugin::LintPrereqs;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Moose;
with 'Dist::Zilla::Role::InstallTool';

use namespace::autoclean;

has lint_prereqs_options => (is=>'rw');

sub setup_installer {
    my ($self) = @_;

    my $opts = $self->lint_prereqs_options // '';
    my $cmd = "lint-prereqs" . (length($opts) ? " $opts" : "");

    system $cmd;
    if ($?) {
        $self->log_fatal("lint-prereqs failed ($?)");
    }
}

__PACKAGE__->meta->make_immutable;
1;
# ABSTRACT: Run lint-prereqs during build

=for Pod::Coverage .+

=head1 SYNOPSIS

In F<dist.ini>:

 [LintPrereqs]
 ;lint_prereqs_options = ...


=head1 DESCRIPTION

This plugin will run L<lint-prereqs> during the InstallTool phase (after all
files has been gathered/munged). If linting succeeds, the build continues.
Otherwise, the build is aborted.


=head1 SEE ALSO

L<lint-prereqs> in L<App::LintPrereqs> distribution.
