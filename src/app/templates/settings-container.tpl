<div class="settings-container">
	<div class="fa fa-times close-icon"></div>
	<div class="sidebar">
		<div class="title"><%= i18n.__("Settings") %></div>
		<div class="user-interface"><%= i18n.__("User Interface") %></div>
		<div class="quality-options"><%= i18n.__("Quality") %></div>
		<div class="subtitles-options"><%= i18n.__("Subtitles") %></div>
		<div class="trakt-options<%= App.Trakt.authenticated ? " authenticated" : "" %>"><%= i18n.__("Trakt.tv") %></div>
		<div class="more-options"><%= i18n.__("More Options") %></div>
		<div class="advanced-settings"><%= i18n.__("Advanced Settings") %></div>
	</div>
	<div class="content">

		<div class="success_alert" style="display:none"><%= i18n.__("Saved") %>&nbsp;<span id="checkmark-notify"><div id="stem-notify"></div><div id="kick-notify"></div></span></div>

		<div class="fa fa-keyboard-o help"></div>

		<div class="user-interface">
			<div class="dropdown subtitles-language">
				<p><%= i18n.__("Default Language") %>:</p>
				<%
					var langs = "";
					for(var key in App.Localization.allTranslations) {
							key = App.Localization.allTranslations[key];
							if (App.Localization.langcodes[key] !== undefined) {
							langs += "<option "+(Settings.language == key? "selected='selected'":"")+" value='"+key+"'>"+
										App.Localization.langcodes[key].nativeName+"</option>";
						}
					}
				%>
				<select name="language"><%=langs%></select>
				<div class="dropdown-arrow"></div>
			</div>

		<div class="dropdown pct-theme">
				<p><%= i18n.__("Theme") %>:</p>

				<%
					var themes = "";
var theme_files = fs.readdirSync('./src/app/themes/');

for (var i in theme_files) {

    if (theme_files[i].indexOf('_theme') > -1) {
        themes += "<option " + (Settings.theme == theme_files[i].slice(0, -4)? "selected='selected'" : "") + " value='" + theme_files[i].slice(0, -4) + "'>" +
            theme_files[i].slice(0, -10).split('_').join(' '); + "</option>";
    }

}

				%>
				
				<select name="theme"><%=themes%></select>
				<div class="dropdown-arrow"></div>
			</div>

			<br><br><br>
			<p>
				<input class="settings-checkbox" name="coversShowRating" id="cb3" type="checkbox" <%=(Settings.coversShowRating? "checked='checked'":"")%>>
				<label class="settings-label" for="cb3"><%= i18n.__("Show movie rating on the cover") %></label>
			</p>
			<br><br><br>
			<p>
				<input class="settings-checkbox" name="alwaysOnTop" id="cb4" type="checkbox" <%=(Settings.alwaysOnTop? "checked='checked'":"")%>>
				<label class="settings-label" for="cb4"><%= i18n.__("Always On Top") %></label>
			</p>
		</div>

		<div class="quality-options">
			<input class="settings-checkbox" name="moviesShowQuality" id="cb1" type="checkbox" <%=(Settings.moviesShowQuality? "checked='checked'":"")%>>
			<label class="settings-label" for="cb1"><%= i18n.__("Show movie quality on list") %></label>
			<br><br>
			<div class="dropdown movies-quality">
				<p><%= i18n.__("Only list movies in") %>:</p>
				<select name="movies_quality">
					<option <%=(Settings.movies_quality == "all"? "selected='selected'":"") %> value="all"><%= i18n.__("All") %></option>
					<option <%=(Settings.movies_quality == "1080p"? "selected='selected'":"") %> value="1080p">1080p</option>
					<option <%=(Settings.movies_quality == "720p"? "selected='selected'":"") %> value="720p">720p</option>
				</select>
				<div class="dropdown-arrow"></div>
			</div>
		</div>

		<div class="subtitles-options">
			<div class="dropdown subtitles-language-default">
				<p><%= i18n.__("Default Subtitle") %>:</p>
				<%
					var sub_langs = "<option "+(Settings.subtitle_language == "none"? "selected='selected'":"")+" value='none'>" +
										i18n.__("Disabled") + "</option>";

					for(var key in App.Localization.langcodes) {
						if (App.Localization.langcodes[key].subtitle !== undefined && App.Localization.langcodes[key].subtitle == true) {
							sub_langs += "<option "+(Settings.subtitle_language == key? "selected='selected'":"")+" value='"+key+"'>"+
											App.Localization.langcodes[key].nativeName+"</option>";
						}
					}
				%>
				<select name="subtitle_language"><%=sub_langs%></select>
				<div class="dropdown-arrow"></div>
			</div>
			<div class="dropdown subtitles-size">
				<p><%= i18n.__("Size") %>:</p>
				<%
					var arr_sizes = ["26px","28px","30px","32px","34px","36px","38px","48px","50px","52px","54px","56px","58px","60px"];

					var sub_sizes = "";
					for(var key in arr_sizes) {
						sub_sizes += "<option "+(Settings.subtitle_size == arr_sizes[key]? "selected='selected'":"")+" value='"+arr_sizes[key]+"'>"+arr_sizes[key]+"</option>";
					}
				%>
				<select name="subtitle_size"><%=sub_sizes%></select>
				<div class="dropdown-arrow"></div>
			</div>
		</div>

		<div class="trakt-options<%= App.Trakt.authenticated ? " authenticated" : "" %>">
			<% if(App.Trakt.authenticated) { %>
				<%= i18n.__("You are currently authenticated to Trakt.tv as") %> <%= Settings.traktUsername %>.
				<a id="unauthTrakt" class="unauthtext" href="#"><%= i18n.__("Disconnect account") %></a>
				<br>
				<div class="btn-settings syncTrakt" id="syncTrakt"><i class="fa fa-refresh">&nbsp;&nbsp;</i><%= i18n.__("Sync With Trakt") %></div>
			<% } else { %>
				<%= i18n.__("Enter your Trakt.tv details here to automatically 'scrobble' episodes you watch in Popcorn Time") %>
				<br><br>
				<p><%= i18n.__("Username") + ":" %></p> <input type="text" size="50" id="traktUsername" name="traktUsername">
				<div class="loading-spinner" style="display: none"></div>
				<div class="valid-tick" style="display: none"></div>
				<div class="invalid-cross" style="display: none"></div>
				<br><br>
				<p><%= i18n.__("Password") + ":" %></p> <input type="password" size="50" id="traktPassword" name="traktPassword">
				<br><br>
				<aside><em><%= i18n.__("Popcorn Time stores an encrypted hash of your password in your local database") %></em></aside>
			<% } %>
		</div>

		<div class="more-options">
			<p><%= i18n.__("TV Show API Endpoint") + ":" %></p> <input id="tvshowApiEndpoint" type="text" size="50" name="tvshowApiEndpoint" value="<%=Settings.tvshowApiEndpoint%>">
		</div>
		<div class="advanced-settings">
			<p><%= i18n.__("Connection Limit") + ":" %></p> <input id="connectionLimit" type="text" size="20" name="connectionLimit" value="<%=Settings.connectionLimit%>"/>
			<br><br>

			<p><%= i18n.__("DHT Limit") + ":" %></p> <input type="text" id="dhtLimit" size="20" name="dhtLimit" value="<%=Settings.dhtLimit%>"/>
			<br><br>

			<p><%= i18n.__("Port to stream on") + ":" %></p> <input id="streamPort" type="text" size="20" name="streamPort" value="<%=Settings.streamPort%>"/> <em><%= i18n.__("0 = Random") %></em>
			<br><br>

			<!-- Cache Directory -->
			<p><%= i18n.__("Cache Directory") %>: </p>
			<input type="text" placeholder="<%= i18n.__("Cache Directory") %>" id="faketmpLocation" value="<%= Settings.tmpLocation %>" readonly="readonly" size="68" /> <i class="open-tmp-folder fa fa-folder-open-o"></i>
			<input type="file" name="tmpLocation" id="tmpLocation" nwdirectory style="display: none;" nwworkingdir="<%= Settings.tmpLocation %>" />
			<br><br>
			<!-- Cache Directory / -->

			<input class="settings-checkbox" name="deleteTmpOnClose" id="cb2" type="checkbox" <%=(Settings.deleteTmpOnClose? "checked='checked'":"")%>>

			<input class="settings-checkbox" name="deleteTmpOnClose" id="cb2" type="checkbox" <%=(Settings.deleteTmpOnClose? "checked='checked'":"")%>>
			<label class="settings-label" for="cb2"><%= i18n.__("Clear Tmp Folder after closing app?") %></label>
			<br><br>
			<input class="settings-checkbox" name="externalPlayer" id="cbPlayer" type="checkbox" <%=(Settings.externalPlayer? "checked='checked'":"")%>>
			<label class="settings-label" for="cbPlayer"><%= i18n.__("Use external video player") %></label>
			<br><br>
			<!-- External Player Location -->
			<div id = "externalPlayerDropdown" class="dropdown external-player" <%= Settings.externalPlayer ? "" : "style= display:none" %>>
				<p><%= i18n.__("External Player") %>:</p>

				<select id="external_player_select" name="externalPlayerLocation">
					<option selected='selected' value='-1'>Loading...</option>
				</select>
				<div class="dropdown-arrow"></div>	
			</div>
			<br><br>
			<div id = "externalPlayerInput" <%= Settings.externalPlayer? "" : "style= display:none" %>>
				<p><%= i18n.__("Path to external player") %>: </p>
				<input type="text" placeholder="<%= i18n.__("External Player") %>" id="fakeExternalPlayerLocation" value="<%= Settings.externalPlayerLocation %>" readonly="readonly" size="68" />
				<input type="file" name="externalPlayerLocationDir" id="externalPlayerLocationDir" style="display: none;" nwworkingdir="<%= Settings.externalPlayerLocation %>" />
				<br><br>
			</div>
			<br><br>
			<!-- External Player Location / -->
		</div>
		<div class="btns">
			<div class="btn-settings flush-bookmarks"><%= i18n.__("Flush bookmarks database") %></div>
			<div class="btn-settings flush-subtitles"><%= i18n.__("Flush subtitles cache") %></div>
			<div class="btn-settings flush-databases"><%= i18n.__("Flush all databases") %></div>
			<div class="btn-settings default-settings"><%= i18n.__("Reset to Default Settings") %></div>
		</div>
	</div>
</div>
