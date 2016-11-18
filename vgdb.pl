#!/usr/bin/perl

# Moderately Complex Perl Program - Video Game List Program
#
# vgdb.pl
#
# Chase Weyer
#
# This program will take standard inputs from the user to create a list of video games and print it to a file.
# If the user enters an incorrect field, or leaves it blank, they will be required to re-enter a correct field.
# If there is already a saved file for the program, it will ask the user if they want to overwrite or append the file.
# Once the program completes, they will be prompted if they would like to view the newly created file.
# Program will run from the command line as vgdb.pl. If there are any more elements in the command line, the program will die.
# If there are errors opening the files for reading or writing, the program will die.
#


use 5.8.8;
use strict;
use warnings;

# initialzed array values

my @console; my @title; my @type; my @yr;

# initialized scalar values
						
my $mode; my $infile = "vgdb.txt"; my $outfile = "vgdb.txt"; my $input; my $ans;	

# will check for additional arguments in the command line.
# will die if more than the program agrument is entered

if ($#ARGV == 0)
{												
	die "Usage: $0 inputfile outputfile\n";
}

print "\nWelcome to the Video Game List Program\n";				

# if saved file exists, will prompt user to overwrite or append file
# if no saved file exists, will overwrite new file

if (-e $infile)										
{
	#file will be opened for reading if saved file exists
	#if there is an error uploading the file, program will die

	open(INPUT, "<$infile") or die "Unable to upload $infile. $!";

	print STDERR "\nSaved file found!\n";

	print STDERR "\nWould you like to overwrite or append the file?: ";
	while ($ans = <>)
	{
		chomp $ans;

		# user will be re-prompted for input if incorrect or empty values are entered and will break loop if entered correctly
		
		if ($ans eq 'O' || $ans eq 'o' || $ans eq 'overwrite' || $ans eq 'Overwrite' || $ans eq 'OVERWRITE')
		{
			$mode='>';
			
			last;
		}
		elsif ($ans eq 'A' || $ans eq 'a' || $ans eq 'append' || $ans eq 'Append' || $ans eq 'APPEND')
		{
			$mode='>>';
			
			last;
		}
		else
		{
			print "\nInvalid Entry. Would you like to overwrite or append the file?: ";
		}#end if elsif else
	}#end while
}
else
{
	$mode='>';
}#end if else

close INPUT;

# user will be prompted for number of games to organize

print "\nPlease enter a number of video games to organize: ";
while ($input = <>)
{
	chomp $input;

	# user will be prompted for re-entry if non-numeric or empty value is entered

	if ($input == 0)
	{
		print "\nInvalid Entry. Please enter a number of games to organize: ";
	}
	else
	{
		last;
	}#end if else
}#end while

my $i = 0;

# depending on the value inputted for games to organize, user will be prompted to enter 3 values for each game 

while ($i < $input)
{
	# user will be prompted to enter a console name

	print "\nPlease enter a console: ";
	while ($console[$i] = <>)
	{
		chomp $console[$i];

		# user will be prompted for re-entry if empty value is entered and will break loop if other value is entered

		if ($console[$i] eq '')
		{
			print "\nInvalid Entry. Please enter a console: ";
		}
		else
		{
			last;
		}#end if else
	}#end while

	# user will be prompted to enter a title

	print "\nPlease enter the title: ";
	while ($title[$i] = <>)
	{
		chomp $title[$i];

		# user will be prompted for re-entry if empty value is entered and will break loop if other value is entered

		if ($title[$i] eq '')
		{
			print "\nInvalid Entry. Please enter the title: ";
		}
		else
		{
			last;
		}#end if else
	}#end while

	# user will be prompted to enter the type of game
	
	print "\nPlease enter the type of game: ";
	while ($type[$i] = <>)
	{
		chomp $type[$i];

		# user will be prompted for re-entry if null value is entered and will break loop if other value is entered

		if ($type[$i] eq '')
		{
			print "\nInvalid Entry. Please enter the type of game: ";
		}
		else
		{
			last;
		}#end if else
	}#end while
}#end while

# initializer to make sure loop will go through all values entered by the user

continue
{
	$i++;
}

# file will be opened for writing results to
# type of write will depend on previous user input or lack of saved file
# file will die if error occurs

open (OUTPUT, "$mode$outfile") or die "Error writing to $outfile. $!.";

# header be printed to new or existing file

print OUTPUT "\n| Console | Title | Type |";
print OUTPUT "\n-------------------------- \n";

# for loop used to call previously ented values and print them to new or existing file

for ($i = 0; $i < $input; $i++)
{
	print OUTPUT "$console[$i] : $title[$i] : $type[$i]\n";
}#end for

close OUTPUT;

# will notify user that file has been saved

print STDERR "\nYour results will be saved to $outfile.\n";

# user will be given option to view newly created file
# user will be re-promted for entry if empty value or incorrect response is entered

print STDERR "\nWould you like to view your results?: ";
while ($ans = <>)
{
	chomp $ans;

	if ($ans eq 'Y' || $ans eq 'y' || $ans eq 'Yes' || $ans eq 'yes')
	{
		open(INPUT, "<$infile") or die "Unable to upload $infile. $!";
	
		while(<INPUT>)
		{
			print "$_.\n";
		}
		
		close INPUT;

		print "\nThank you for using the Video Game List Program\n";

		last;
	}
	elsif ($ans eq 'N' || $ans eq 'n' || $ans eq 'No' || $ans eq 'no' || $ans eq 'NO')
	{
		print "\nThank you for using the Video Game List Program\n";

		last;
	}
	else
	{
		print "\nInvalid Entry. Please enter a valid response: ";
	}#end if elsif else
}#end while
	

exit;
