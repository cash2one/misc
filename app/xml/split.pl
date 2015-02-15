#! /usr/bin/perl 
# 	gusimiu@baidu.com
#
#  ��һ�ݴ�xml��ֳɶ��Сxml��������sitemap.
#  ���ÿ��sitemap��keyҲ�������ƣ�������ɶ��sitemap	
# Usage:
# 	./split.pl <BIG_XML>
#
# NOTICE:
# 	���������������utf8��ʽxml�������һ���ǵ��ö�������ں�̨ת�������Կ���
# 	���ڳ��������ת����û��ɵ��������Ҫ�ȴ���

use Encode;

# === ���ò��� ===
#	sitemap�У���ӦĿ¼��http��ַ 
my $url_prefix = "http://bb-rank-testc009.vm.baidu.com:8080/right-baike";

#  sitemap���ǰ׺, ���ɵ�sitemap��$prefix[0-9].xml��ô������ȥ
my $sitemap_prefix = "right-baike-sitemap_"; 

# �����gbĿ¼��Ĭ�������BIG_XML��gb18030��ʽ�ģ�û���Թ�����utf8������Ƿ����
my $dir="right-baike_gb";

# �����utf8Ŀ¼��
my $dir2="right-baike";

# ����xml��key���ƣ�ƽ̨������10M������ע����������������
my $single_xml_key_limit = 5000;

# ����sitemap������key������, Ŀǰƽ̨��������100000.
my $single_sitemap_key_limit = 90000;

# === ���ý��� ===

$sid = 0;
$kid = 0;
open OFP, ">$sitemap_prefix$sid.xml" or die;
print OFP "<sitemapindex xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n";

$fid=0;
`rm -rf $dir`;
`mkdir $dir`;
while (<>) {
	next if /<\?*xml/;
	next if /<\/*DOCUMENT>/;

	$output .= $_;

	if (/<\/item>/) {
		$it++;	
		$kid++;
		&over if $it>$single_xml_key_limit;
	} 
}
&over;

sub over {
	print OFP 
"	<sitemap>
		<loc>$url_prefix/$fid.xml</loc>
		<lastmod>2012-12-13</lastmod>
	</sitemap>\n";	
	if ( $kid>=$single_sitemap_key_limit ) {
		$kid = 0;
		$sid ++;
		print OFP "</sitemapindex>\n";
		close OFP;
		open OFP, ">$sitemap_prefix$sid.xml" or die;
		print OFP "<sitemapindex xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n";
	}

	open FP, ">$dir/$fid.xml" or die; 
	print FP "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n";
	print FP "<DOCUMENT>\n";
	print FP $output;
	print FP "</DOCUMENT>\n";
	close FP;

	$output = "";
	$it = 0;
	$fid++;
}

print OFP "</sitemapindex>\n";
close OFP;

`rm -rf $dir2; mkdir $dir2`;
for $fn (split /\n/, `ls $dir`) {
	print $fn."\n";
	`./trans.pl < $dir/$fn > $dir2/$fn &`;
}


