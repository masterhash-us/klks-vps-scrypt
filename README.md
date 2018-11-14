<p><a href="http://www.kalkulus.trade/"><img style="display: block; margin-left: auto; margin-right: auto;" src="https://i.imgur.com/TDhrEOP.png" /></a>&nbsp;</p>
<h2>Kalkulus VPS Installation Scrypt</h2>
<p>--------------------------------------------------------------------------------------------------------------------</p>
<p><strong>**Please note: </strong>this script is still working but the support is discontinued. If you are looking for an automated way to deploy a masternode without any skill or without compiling libraries we suggest to register an account on&nbsp;<a href="https://hub.kalkul.us/" target="_blank" rel="noopener">https://hub.kalkul.us</a> for esy masternode deployment.</p>
<p>--------------------------------------------------------------------------------------------------------------------</p>
<p><br /> This simple scrypt automatically install and setup your VPS server for running a Kalkulus masternode.</p>
<p>Login to your VPS with your credential using Putty.</p>
<p>Download and execute script with following commands:&nbsp;</p>
<p><em>git clone&nbsp;<a href="https://github.com/kalkulusteam/klks-vps-scrypt.git">https://github.com/kalkulusteam/klks-vps-scrypt.git</a></em></p>
<p><em>chmod +x klks_vps_scrypt</em></p>
<p><em>./klks_vps_scrypt</em></p>
<p>The script will now be executed, and will require following information:</p>
<ul>
<li>Masternode genkey (you will get your key with command&nbsp;&nbsp;<em>masternode genkey&nbsp;</em>&nbsp;in your desktop wallet )</li>
<li>Public IP Address of your VPS</li>
<li>Agree to create swap (this is recommended for a VPS with 2GB or less)</li>
<li>Agree to setup firewall rules (recommended)</li>
<li>Agree to setup fail2bad (this is recommended to prevent ssh bruteforcers)</li>
</ul>
<p>The script will now configure and update the system, download and install the KLKS distribution, create the required masternode configuration file, and start the KLKS daemon under the new KLKS user the script created.</p>
<p>More information at <a href="http://www.kalkulus.trade" target="_blank" rel="noopener">http://kalkulus.trade/wp/vps-scrypt</a></p>
<p>&nbsp;<strong>Links</strong></p>
<table style="width: 375px;">
<tbody>
<tr>
<td style="width: 93px;"><strong>Twitter</strong></td>
<td style="width: 270px;">https://twitter.com/kalkulus_team</td>
</tr>
<tr>
<td style="width: 93px;"><strong>Discord Chat</strong></td>
<td style="width: 270px;"><a href="https://discord.gg/UHDWDKT">Discord chat</a></td>
</tr>
<tr>
<td style="width: 93px;"><strong>Website</strong></td>
<td style="width: 270px;"><a href="http://kalkulus.trade/">http://www.kalkulus.trade</a></td>
</tr>
</tbody>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
