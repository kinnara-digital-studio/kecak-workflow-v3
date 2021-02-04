package org.kecak.apps.route;

import org.apache.camel.builder.RouteBuilder;
import org.joget.commons.util.SetupManager;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.Nonnull;

/**
 * The builder will be executed in 2 points, during inital loading and
 * saving Settings
 */
public class EmailProcessorRouteBuilder extends RouteBuilder {
	private SetupManager setupManager;

    @Override
	public void configure() {
		@Nonnull String emailAccount = setupManager.getSettingValue("emailAccount");
		@Nonnull String emailPassword = setupManager.getSettingValue("emailPassword");
		@Nonnull String emailProtocol = setupManager.getSettingValue("emailProtocol");
		@Nonnull String emailHost = setupManager.getSettingValue("emailHost");
		@Nonnull String emailPort = setupManager.getSettingValue("emailPort");
		@Nonnull String emailFolder = setupManager.getSettingValue("emailFolder");

		// set default port
		if(emailPort.isEmpty()) {
			if("imap".equalsIgnoreCase(emailProtocol))
				emailPort = "143"; // default IMAP
			else if("imaps".equalsIgnoreCase(emailProtocol))
				emailPort = "993"; // default IMAPS
		}

		// set default folder
		if(emailFolder.isEmpty())
			emailFolder = "INBOX";

		if (!emailAccount.isEmpty() && !emailPassword.isEmpty() && !emailProtocol.isEmpty() && !emailHost.isEmpty() && !emailPort.isEmpty()) {

			StringBuilder fromUriBuilder = new StringBuilder();
			fromUriBuilder.append(emailProtocol).append("://").append(emailHost).append(":").append(emailPort);
			fromUriBuilder.append("?username=").append(emailAccount);
			fromUriBuilder.append("&password=").append(emailPassword);
			fromUriBuilder.append("&folderName=").append(emailFolder);
			fromUriBuilder.append("&delete=false&unseen=true");

			String fromUri = fromUriBuilder.toString();
			from(fromUri).beanRef("emailProcessor", "parseEmail");
		}
	}

	public void setSetupManager(SetupManager setupManager) {
		this.setupManager = setupManager;
	}
}