package Image::Size::FillFullSelect;

use Image::Size;
use warnings;
use strict;

=head1 NAME

Image::Size::FillFullSelect - Choose wether a image fill setting for a image should be fill or full.

=head1 VERSION

Version 0.0.1

=cut

our $VERSION = '0.0.1';


=head1 SYNOPSIS

Decides if the fill setting for a image should be either fill,
in meaning the image should be resized to fix the screen, or full
which means it should be scaled to fit the screen.

    use Image::Size::FillFullSelect;

    my $iffs = Image::Size::FillFullSelect->new();
    my $FFselection = $iffs->select("someImage.gif");

=head1 FUNCTIONS

=head2 new

This creates a new Image::Size::FillFullSelect object.

It takes one optional arguement, which is a integer that
represents the maximum difference between the X and Y
dimensions of a image. The default is .2, which means
the maximum differce between either can be 20%.

=cut

sub new {
	my $hash;
	
	if(defined($_[1])){
		$hash={maxdiff=>$_[1]};
	}else{
		$hash={maxdiff=>".2"};
	};

	bless $hash;
	return $hash;
}

=head2 select

This makes the selection between the two.

There is one required arguement and one optional arguement. The first
is the page to the image and it is required. The second is the max
difference between the two sides and it is optional. If it is
not defined, the default is used.

Upon a error, it returns undef.

=cut

sub select{ #arg1=the image to use  arg2=the max difference
	my ($self, $image, $maxdiff)=@_;
	my ($imageX, $imageY)=imgsize("$image");

	#use the default if it is defined.
	if(!defined($maxdiff)){
		$maxdiff=$self->{maxdiff};
	};

	if (!$imageX){
		warn($image." is not a image\n");
		return undef;
	};
	#this needs done twice since one direction only can't be trusted...
	my $ixydiff1=$imageX/$imageY - 1; #gets the scale difference...
	$ixydiff1=abs($ixydiff1); #make the scale differ into a absolute value for easier use
	my $ixydiff2=$imageY/$imageX - 1; #gets the scale in the other directions...
	$ixydiff2=abs($ixydiff2); #abs the other one also

	if ($ixydiff1 <= $maxdiff || $ixydiff2 <= $maxdiff){
		return "fill";
	}else{
		return "full";
	};
};


=head1 AUTHOR

Zane C. Bowers, C<< <vvelox at vvelox.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-image-size-fillfullselect at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Image-Size-FillFullSelect>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Image::Size::FillFullSelect


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Image-Size-FillFullSelect>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Image-Size-FillFullSelect>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Image-Size-FillFullSelect>

=item * Search CPAN

L<http://search.cpan.org/dist/Image-Size-FillFullSelect>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2008 Zane C. Bowers, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Image::Size::FillFullSelect
