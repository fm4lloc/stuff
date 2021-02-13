#!/usr/bin/perl

#---------------------------------------------------------------------#
# Name: colorls                                                       #
# Description: list file/directory information/with icons and colors  #
# Author: Fernando Magalhães, <fm4lloc[dot]gmail.com>                 #
# License: GNU General Public License version 2                       #
#---------------------------------------------------------------------#

use strict;
use warnings;
use feature qw{ say };
use open ':locale';

# ---- filetype, hex icons
my %f_ex = (
	"apk" =>,               "\x{e70e}",	
	"apk" =>,               "\x{e70e}",	
	"avi" =>,               "\x{f03d}",	
	"avro" =>,              "\x{e60b}",	
	"awk" =>,               "\x{f489}",	
	"bash" =>,              "\x{f489}",	
	"bash_history" =>,      "\x{f489}",	
	"bash_profile" =>,      "\x{f489}",	
	"bashrc" =>,            "\x{f489}",	
	"bat" =>,               "\x{f17a}",	
	"bio" =>,               "\x{f910}",	
	"bmp" =>,               "\x{f1c5}",	
	"c" =>,                 "\x{e61e}",	
	"c++" =>,               "\x{e61d}",	
	"cc" =>,                "\x{e61d}",	
	"cfg" =>,               "\x{e615}",	
	"clj" =>,               "\x{e768}",	
	"cljs" =>,              "\x{e76a}",	
	"cls" =>,               "\x{e600}",	
	"coffee" =>,            "\x{f0f4}",	
	"conf" =>,              "\x{e615}",	
	"cp" =>,                "\x{e61d}",	
	"cpp" =>,               "\x{e61d}",	
	"cs" =>,                "\x{f81a}",	
	"cshtml" =>,            "\x{f1fa}",	
	"csproj" =>,            "\x{f81a}",	
	"csx" =>,               "\x{f81a}",	
	"csh" =>,               "\x{f489}",	
	"css" =>,               "\x{e749}",	
	"csv" =>,               "\x{f1c3}",	
	"cxx" =>,               "\x{e61d}",	
	"d" =>,                 "\x{e7af}",	
	"dart" =>,              "\x{e798}",	
	"db" =>,                "\x{f1c0}",	
	"diff" =>,              "\x{f440}",	
	"doc" =>,               "\x{f1c2}",	
	"docx" =>,              "\x{f1c2}",	
	"ds_store" =>,          "\x{f179}",	
	"dump" =>,              "\x{f1c0}",	
	"ebook" =>,             "\x{e28b}",	
	"editorconfig" =>,      "\x{e615}",	
	"ejs" =>,               "\x{e618}",	
	"elm" =>,               "\x{e62c}",	
	"env" =>,               "\x{f462}",	
	"eot" =>,               "\x{f031}",	
	"epub" =>,              "\x{e28a}",	
	"erb" =>,               "\x{e73b}",	
	"erl" =>,               "\x{e7b1}",	
	"exe" =>,               "\x{f17a}",	
	"ex" =>,                "\x{e62d}",	
	"exs" =>,               "\x{e62d}",	
	"fish" =>,              "\x{f489}",	
	"flac" =>,              "\x{f001}",	
	"flv" =>,               "\x{f03d}",	
	"font" =>,              "\x{f031}",
	"/" =>,                 "\x{1f5c1}",
	"file"	=>,             "\x{1f5cb}",
	"fpl" =>,               "\x{f910}",	
	"gdoc" =>,              "\x{f1c2}",	
	"gemfile" =>,           "\x{e21e}",	
	"gemspec" =>,           "\x{e21e}",	
	"gform" =>,             "\x{f298}",	
	"gif" =>,               "\x{f1c5}",	
	"git" =>,               "\x{f1d3}",	
	"go" =>,                "\x{e626}",	
	"gradle" =>,            "\x{e70e}",	
	"gsheet" =>,            "\x{f1c3}",	
	"gslides" =>,           "\x{f1c4}",	
	"guardfile" =>,         "\x{e21e}",	
	"gz" =>,                "\x{f410}",	
	"h" =>,                 "\x{f0fd}",	
	"hbs" =>,               "\x{e60f}",	
	"hpp" =>,               "\x{f0fd}",	
	"hs" =>,                "\x{e777}",	
	"htm" =>,               "\x{f13b}",	
	"html" =>,              "\x{f13b}",	
	"hxx" =>,               "\x{f0fd}",	
	"ico" =>,               "\x{f1c5}",	
	"image" =>,             "\x{f1c5}",	
	"iml" =>,               "\x{e7b5}",	
	"ini" =>,               "\x{e615}",	
	"ipynb" =>,             "\x{e606}",	
	"jar" =>,               "\x{e204}",	
	"java" =>,              "\x{e204}",	
	"jpeg" =>,              "\x{f1c5}",	
	"jpg" =>,               "\x{f1c5}",	
	"js" =>,                "\x{e74e}",	
	"json" =>,              "\x{e60b}",	
	"jsx" =>,               "\x{e7ba}",	
	"ksh" =>,               "\x{f489}",	
	"less" =>,              "\x{e758}",	
	"lhs" =>,               "\x{e777}",	
	"license" =>,           "\x{f48a}",	
	"localized" =>,         "\x{f179}",	
	"lock" =>,              "\x{f023}",	
	"log" =>,               "\x{f18d}",	
	"lua" =>,               "\x{e620}",	
	"m3u" =>,               "\x{f910}",	
	"m3u8" =>,              "\x{f910}",	
	"m4a" =>,               "\x{f001}",	
	"markdown" =>,          "\x{f48a}",	
	"md" =>,                "\x{f48a}",	
	"mkd" =>,               "\x{f48a}",	
	"mkv" =>,               "\x{f03d}",	
	"mobi" =>,              "\x{e28b}",	
	"mov" =>,               "\x{f03d}",	
	"mp3" =>,               "\x{f001}",	
	"mp4" =>,               "\x{f03d}",	
	"mustache" =>,          "\x{e60f}",	
	"nix" =>,               "\x{f313}",	
	"npmignore" =>,         "\x{e71e}",	
	"opus" =>,              "\x{f001}",	
	"ogg" =>,               "\x{f001}",	
	"ogv" =>,               "\x{f03d}",	
	"otf" =>,               "\x{f031}",	
	"pdf" =>,               "\x{f1c1}",	
	"php" =>,               "\x{e73d}",	
	"pl" =>,                "\x{e769}",	
	"pls" =>,               "\x{f910}",	
	"png" =>,               "\x{f1c5}",	
	"ppt" =>,               "\x{f1c4}",	
	"pptx" =>,              "\x{f1c4}",	
	"procfile" =>,          "\x{e21e}",	
	"properties" =>,        "\x{e60b}",	
	"ps1" =>,               "\x{f489}",	
	"psd" =>,               "\x{e7b8}",	
	"pxm" =>,               "\x{f1c5}",	
	"py" =>,                "\x{e606}",	
	"pyc" =>,               "\x{e606}",	
	"r" =>,                 "\x{f25d}",	
	"rakefile" =>,          "\x{e21e}",	
	"rar" =>,               "\x{f410}",	
	"razor" =>,             "\x{f1fa}",	
	"rb" =>,                "\x{e21e}",	
	"rdata" =>,             "\x{f25d}",	
	"rdb" =>,               "\x{e76d}",	
	"rdoc" =>,              "\x{f48a}",	
	"rds" =>,               "\x{f25d}",	
	"readme" =>,            "\x{f48a}",	
	"rlib" =>,              "\x{e7a8}",	
	"rmd" =>,               "\x{f48a}",	
	"rs" =>,                "\x{e7a8}",	
	"rspec" =>,             "\x{e21e}",	
	"rspec_parallel" =>,    "\x{e21e}",	
	"rspec_status" =>,      "\x{e21e}",	
	"rss" =>,               "\x{f09e}",	
	"ru" =>,                "\x{e21e}",	
	"rubydoc" =>,           "\x{e73b}",	
	"sass" =>,              "\x{e603}",	
	"scala" =>,             "\x{e737}",	
	"scss" =>,              "\x{e749}",	
	"sh" =>,                "\x{f489}",	
	"shell" =>,             "\x{f489}",	
	"slim" =>,              "\x{e73b}",	
	"sln" =>,               "\x{e70c}",	
	"sql" =>,               "\x{f1c0}",	
	"sqlite3" =>,           "\x{e7c4}",	
	"styl" =>,              "\x{e600}",	
	"stylus" =>,            "\x{e600}",	
	"svg" =>,               "\x{f1c5}",	
	"swift" =>,             "\x{e755}",	
	"tar" =>,               "\x{f410}",	
	"tex" =>,               "\x{e600}",	
	"tiff" =>,              "\x{f1c5}",	
	"ts" =>,                "\x{e628}",	
	"tsx" =>,               "\x{e7ba}",	
	"ttf" =>,               "\x{f031}",	
	"twig" =>,              "\x{e61c}",	
	"txt" =>,               "\x{f15c}",	
	"video" =>,             "\x{f03d}",	
	"vim" =>,               "\x{e62b}",	
	"vlc" =>,               "\x{f910}",	
	"vue" =>,               "\x{fd42}",	
	"wav" =>,               "\x{f001}",	
	"webm" =>,              "\x{f03d}",	
	"webp" =>,              "\x{f1c5}",	
	"windows" =>,           "\x{f17a}",	
	"wma" =>,               "\x{f001}",	
	"wmv" =>,               "\x{f03d}",	
	"wpl" =>,               "\x{f910}",	
	"woff" =>,              "\x{f031}",	
	"woff2" =>,             "\x{f031}",	
	"xls" =>,               "\x{f1c3}",	
	"xlsx" =>,              "\x{f1c3}",	
	"xml" =>,               "\x{e619}",	
	"xul" =>,               "\x{e619}",	
	"yaml" =>,              "\x{e60b}",	
	"yml" =>,               "\x{e60b}",	
	"zip" =>,               "\x{f410}",	
	"zsh" =>,               "\x{f489}",	
	"zsh-theme" =>,         "\x{f489}",	
	"zshrc" =>,             "\x{f489}",
);

#---------------------------------------------------------------------#
#       List file/directory information/with icons and colors         #
#---------------------------------------------------------------------#
sub main ()
{
	my $color 	= 127; 								# range colors
	my $m_color = 255;								# max range colors
	my $key_c 	= 0;								# key controls
	my $args 	= join  ("", @ARGV);				# join arguments
	my @ls_file = split (m/\n/, `ls -p @ARGV`);		# split ls to array
	#print_lsd sprintf(">>%s", $f_ex{'/'} . "<<\n");
	
	for (my $i = 0; $i < scalar @ls_file; $i++)
	{
		for (keys %f_ex)
		{
			$key_c++;
			# ---- check folder
			if ($ls_file[$i] =~ /\/$/)
			{
				print("$f_ex{'/'}  ");
				$key_c = 0;
				last;
			}
			# ---- check file
			elsif ($ls_file[$i] =~ /\.$_$/)
			{
				print ("$f_ex{$_}  ");
				$key_c = 0;
				last;
			}
		}
		# ---- check undefined file
		if ($key_c == scalar %f_ex	&&
			$args  !~ /--version/	&&
			$args  !~ /--help/		&&
			$args  !~ /-m/)
		{
			print ("$f_ex{'file'}  ");
			$key_c = 0;
		}
		
		$color = 127 if ($color >= $m_color);
		printf ("\33[38;5;%dm%s\033[0m\n", $color, $ls_file[$i]);
		$color++;
	}
	
	return 0;
}

main ();
