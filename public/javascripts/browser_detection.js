function BrowserDetection() {
                var majorVersion = parseInt(navigator.appVersion,10);
                var upgradeMessage = "Your browser is not up to date. To enjoy the Modern Man Manual, upgrade.";
                var changeMessage = "Modern Man Manual works best with the latest versions of Safari and Chrome. Some features will not work with this browser. For maximum return on enjoyment consider switching."
                
                //Check if browser is IE or not
                if (navigator.userAgent.search("MSIE") >= 0) {
                    alert("Don't use IE! Hackers are already exploiting it. Even worse, Modern Man Manual will not work with IE.");
                }
                //Check if browser is Chrome or not
                else if (navigator.userAgent.search("Chrome") >= 0) {
                     if (majorVersion < 5) {
                        alert(upgradeMessage);
                    }
                }
                //Check if browser is Firefox or not
                else if (navigator.userAgent.search("Firefox") >= 0) {
                    alert(changeMessage);
                }
                //Check if browser is Safari or not
                else if (navigator.userAgent.search("Safari") >= 0 && navigator.userAgent.search("Chrome") < 0) {
                    if (majorVersion < 5) {
                        alert(upgradeMessage);
                    }
                }
                //Check if browser is Opera or not
                else if (navigator.userAgent.search("Opera") >= 0) {
                    alert(changeMessage);
                }
            }