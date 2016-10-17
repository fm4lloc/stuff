#ifndef RFC3986_H_
#define RFC3986_H_

/* 
 * Copyright (C) 2014  Fernando Magalhães (fm4lloc) <fm4lloc@gmail.com>
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 */
 
/*
 * Regexp Common URI
 * Uniform Resource Identifier (URI) : Generic Syntax
 * RFC 3986, base definitions : http://tools.ietf.org/html/rfc3986 
 */ 


/* Lowlevel definitions */
#define DIGIT			"[0-9]"
#define DIGITS  		"[0-9]+"
#define HIALPHA 		"[A-Z]"
#define LOWALPHA		"[a-z]"
#define ALPHA			"[a-zA-Z]"					/* lowalpha / hialpha */
#define ALPHADIGIT		"[a-zA-Z0-9]"				/* alpha / digit   */
#define HEXDIG			"[a-fA-F0-9]"
#define PCT_ENCODED		"(%" HEXDIG HEXDIG ")"
#define GEN_DELIMS		"[][:/?#@]"
#define SUB_DELIMS		"[!$&'()*+,;=]"
#define RESERVED		GEN_DELIMS "|" SUB_DELIMS	/* gen-delims & sub-delims */
#define UNRESERVED		"[a-zA-Z0-9._~-]"			/* ALPHA / DIGIT / "-" / "." / "_" / "~" */
#define PCHAR			"(" UNRESERVED "|" SUB_DELIMS "|[:@]|" PCT_ENCODED ")"
#define REG_NAME		"((" UNRESERVED "|" SUB_DELIMS "|" PCT_ENCODED ")*)"
#define DEC_OCTET		"(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"	/* 0 to 255 */

/* Connection related stuff */

/* Scheme */
#define SCHEME			"(" ALPHA "(" ALPHADIGIT "|[+.-]" ")*)"

/* Port */
#define PORT "(" DIGITS ")"

/* Ipv4 representation */
#define IPV4ADDRESS		"((" DEC_OCTET "[.]){3}" DEC_OCTET ")"
/* Ipv6 representation */
#define H16				HEXDIG "{1,4}" /* 16 bits of address represented in hexadecimal */
#define LS32			"(" H16 ":" H16 ")|" IPV4ADDRESS

#define IPV6ADDRESS		"(" H16 ":){6}"	LS32 "|" \
						"::(" H16 ":){5}"	LS32 "|" \
						"(" H16 ")?::(" H16 ":){4}"	LS32 "|" \
						"((" H16 ":){0,1}" H16 ")?::(" H16 ":){3}"	LS32 "|" \
						"((" H16 ":){0,2}" H16 ")?::(" H16 ":){2}"	LS32 "|" \
						"((" H16 ":){0,3}" H16 ")?::"  H16 ":"		LS32 "|" \
						"((" H16 ":){0,4}" H16 ")?::"				LS32 "|" \
						"((" H16 ":){0,5}" H16 ")?::"				H16  "|" \
						"((" H16 ":){0,6}" H16 ")?::"
				
#define IPVFUTURE		"((" HEXDIG ")+[.](" UNRESERVED "|" SUB_DELIMS "|:)+)"
#define IP_LITERAL 		"\\[(" IPVFUTURE "|" IPV6ADDRESS ")\\]"

/* Host */
#define HOST 			"(" REG_NAME "|" IP_LITERAL "|" IPV4ADDRESS ")"
#define HOSTPORT 		"(" HOST "(:" PORT ")?)"

/* User Information and Authority */
#define USER			"((" UNRESERVED "|" SUB_DELIMS "|" PCT_ENCODED ")*)"
#define PASSWORD		"((" UNRESERVED "|" SUB_DELIMS "|" PCT_ENCODED ")*)"
#define USERINFO 		"(" USER "(:" PASSWORD ")?)"
#define AUTHORITY		"((" USERINFO "@)?" HOSTPORT ")"

/* Path */
#define SEGMENT 		"((" PCHAR ")*)"
#define SEGMENT_NZ		"((" PCHAR ")+)"
#define SEGMENT_NZ_NC	"((" UNRESERVED "|" SUB_DELIMS "|" PCT_ENCODED "|[@])+)"
#define PATH_ABEMPTY	"((/" SEGMENT ")*)"						/* begins with "/" or is empty  */
#define PATH_ABSOLUTE	"(/(" SEGMENT_NZ  "(/" SEGMENT ")*)?)"	/* begins with "/" but not "//" */
#define PATH_NOSCHEME 	"(" SEGMENT_NZ_NC "(/" SEGMENT ")*)"	/* begins with a non-colon segment */
#define PATH_ROOTLESS	"(" SEGMENT_NZ "(/" SEGMENT ")*)"		/* begins with a segment */
#define PATH_EMPTY		"()"									/* zero characters */

/* Query and Fragment */
#define QUERY			"((" PCHAR "|[/?])*)"
#define FRAGMENT		"((" PCHAR "|[/?])*)"

/* URI Reference */
#define RELATIVE_PART	"(//" AUTHORITY PATH_ABEMPTY \
						"|" PATH_ABSOLUTE \
						"|" PATH_NOSCHEME \
						"|" PATH_EMPTY ")"
						
#define RELATIVE_REF	"(" RELATIVE_PART "([?]" QUERY ")?(#" FRAGMENT ")?)"
#define HIER_PART		"(//" AUTHORITY PATH_ABEMPTY \
						"|" PATH_ABSOLUTE \
						"|" PATH_NOSCHEME \
						"|" PATH_ROOTLESS \
						"|" PATH_EMPTY ")"
									
#define URI 			"(" SCHEME ":" HIER_PART "([?]" QUERY ")?(#" FRAGMENT ")?)"
#define URI_REFERENCE 	"(" URI "|" RELATIVE_REF ")"

#endif /* RFC3986_H_ */
