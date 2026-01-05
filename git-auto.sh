#!/bin/bash

echo -e "\n WELCOME TO:"

echo -e "

////////////    ///  //////////////   ///////////  ///      ///  ///////////////  /////////////
///     ///             ///           ///    ///   ///      ///      ///          ///      ///
///             ///     ///           ///    ///   ///      ///      ///          ///      ///
///             ///     ///    ///    //////////   ///      ///      ///          ///      ///
///   ////////  ///     ///           ///    ///   ///      ///      ///          ///      ///
///     ///     ///     ///           ///    ///   ///      ///      ///          ///      ///
/////////       ///     ///           ///    ///   ////////////      ///          ////////////

											version 1.2	"
echo -e "\n A Tool to Automate Git Operations"

sleep 1

git_install() {
	echo -e "\nInstalling Git..."
    	sleep 2
    	echo -e "\nUpdating sources..."
    	update_output=$(sudo apt update 2>&1)
    	update_status=$?
    	echo "$update_output" | grep -q "Failed to fetch"
    	fetch_error=$?

    	if [ $fetch_error -eq 0 ]; then
        	echo -e "\nDownload Error occurred! , Failed to fetch :( "
        	sleep 1
        	gitmaster
        	return
    	fi

    	if [ $update_status -ne 0 ]; then
        	echo -e "\nError occurred during update! :( "
        	sleep 1
        	gitmaster
        	return
    	fi

    	echo -e "\nInstalling git package..."
    	sudo apt install -y git
    	if [ $? -ne 0 ]; then
        	echo -e "\nInstallation Error occurred! :( "
        	sleep 1
        	gitmaster
        	return
    	fi

    	echo -e "\nInstallation Complete! :) "
    	sleep 1
    	echo -e "\nChecking Git version..."
    	sleep 1
    	git --version
}

git_config(){
   declare n=0
   while [ $n -ne 2 ]; do
	echo -e "\n\nGit configuration:"
	echo -e "------------------"
	read -p "Enter your GitHub username: " username
	read -p "Enter your GitHub email: " email
	echo -e "\nSetting up your username..."
	sleep 1
	git config --global user.name "$username"
	echo -e "\nSetting up your email..."
	sleep 1
	git config --global user.email "$email"
	echo -e "\n\nYour Git settings"
	git config --list
	echo
	read -p "Are the GitHub details above correct?[y/n] " reply
	if [ $reply = "y" ]; then
		echo -e "\nCongratulations!, your GitHub details have been configured successfully :) \nNow you can create your local repository"
		gitmaster
	fi
	((n++))
		echo -e "\nWait a moment..._:00.."
		sleep 1
   done
}

git_localrepo(){
	read -p "Enter your Git repo name: " reponame
	echo -e "\nCreating your local repo..."
	sleep 1
	mkdir $reponame
	echo -e "\nMoving to your local repo..."
	cd ./$reponame
	echo -e "\nNow you are in your local repo\n"
	pwd
	sleep 1
	echo
	echo -e "You can proceed with your project :) "
	sleep 1
	echo -e "\nIntiating project..."
	git init
	sleep 2
	echo -e "\nAdd a file into your local-repo $reponame, commit and then push\n"
	sleep 2
}

git_clone(){
	read -p "Enter repository name to clone: " reponame
	echo -e "\nCloning..."
	sleep 1
	git clone $reponame
	 if [ $? -ne 0 ]; then
                git_error
        fi
	echo -e "\nMoving into $reponame ..."
	sleep 1
	cd $reponame
}

readme(){
	echo -e "\n\nAll about README.md\n-------------------\n1.Create README.md\n2.Edit README.md\n3.Append README.md\n4.Delete README.md\n"
	read -p "Enter your option: " option
	case $option in
		1)echo -e "\nCurrent project folder content"|ls -lsa
			sleep 2
			echo -e "\nCreating README.md ..."|sleep 2
			touch README.md
			sleep 1|echo -e "\nOpening README.md ..."
			sleep 1
			nano README.md
		;;
		2)echo -e "\nOpening README.md to edit..."
			sudo find / -name .README.md -o -name .README.md 2>/dev/null
			if [ $? -ne 0  ]; then
				echo -e "\nFile not found!!! "
				git_error
				gitmaster
			fi
			sleep 1
			nano README.md
		;;
		3)echo -e "\nGetting ready to append  README.md to ..."
			sudo find / -name .README.md -o -name .README.md 2>/dev/null
                        if [ $? -ne 0  ]; then
                                echo -e "\nFile not found!!! "
                                git_error
                                gitmaster
                        fi
			sleep 1
			cat >> README.md
		;;
		4)echo -e "\nDeleting README.md press CTRL + C to cancel ..."
		sleep 2
		sudo find / -name .README.md -o -name .README.md 2>/dev/null
                        if [ $? -ne 0  ]; then
                                echo -e "\nFile not found!!! "
                                git_error
                                gitmaster
                        fi
                        sleep 1
		rm -rf README.md|echo -e "\nCurrent folder contents"
		ls -lsa
		sleep 2
		;;
		*)echo -e "\nOption not found! :( "
                        sleep 2;;
		esac
}

git_pull(){
	echo -e "\nPulling resources..."
	sleep 1
	git pull
	 if [ $? -ne 0 ]; then
                git_error
        fi
	echo -e "\nPull operation completed successfully! :) "
}

gitmaster(){
while true; do
	echo -e "\n\n Git Operations:\n --------------------------------\n| 1.Install_Git			|\n| 2.Configure_Git		|\n| 3.Create_sshkey		|\n| 4.Create_Localrepo		|\n| 5.Clone_repo			|\n| 6.Commit			|\n| 7.Push			|\n| 8.Pull			|\n| 9.README.md			|\n| 10.Custom Command		|\n| 11.Clear Terminal		|\n| 12.Exit			|\n --------------------------------\n"
#	read -p "Enter your choice: " option
	echo -e -n "Enter your choice: "
	read option
		case $option in
			1) git_install;;
			2) git_config;;
			3) git_ssh_keygen;;
			4) git_localrepo;;
			5) git_clone;;
			6) git_commit;;
			7) git_push;;
			8) git_pull;;
			9)readme;;
			10)
				echo -e -n "Enter your command: " 
				IFS= read -r cmd
				echo "Debug: Command to execute: '$cmd'"
    				echo "Debug: Current directory: $(pwd)"
    				echo "Debug: Home directory: $HOME"

    				echo -e "\nExecuting..."
    				sleep 2
    				echo -e "\nCommand result(s):"
    				echo -e "------------------"
				if eval "$cmd" 2>/dev/null; then
        				echo -e "\nCommand succeeded :) \n"
    				else
        				echo "Command failed with exit code: $?"
        				echo -e "\nError output:"
        				eval "$cmd" 2>&1
        				git_error
    				fi
				;;
			11) clear;;
			12)
			echo -e "\nClosing..."
			sleep 1
			clear
				exit;;
			*)echo -e "\nOption not found! :( "
			sleep 2;;

		esac
done

}

git_commit(){
        read -p "Enter filename or type '.' for all files : " action
        echo -e -n "\nEnter commit message: "
	read -r message
        echo -e "\nTracking..."
        sleep 1
        git add $action
        if [ $? -ne 0 ]; then
                git_error
        fi
        echo -e "\nCommitting with message: \"$message\" ..."
        sleep 1
        git commit -m "$message"
        git status
}

git_push() {
	echo
	read -p 'Enter "a" or "A" to autopush, or "u" or "U" to enter repository URL: ' choice
	echo
	if [[ "$choice" = "a" || "$choice" = "A" ]]; then
    		git push
		gitmaster
	elif [[ "$choice" = "u" || "$choice" = "U" ]]; then
    		read -p "Enter your repository URL (HTTPS or SSH): " url
	else
		echo -e "Invalid choice!"
		sleep 1
		git_error
	fi

	if [[ "$url" =~ ^https://github.com/(.+)/(.+)\.git$ ]]; then
		user="${BASH_REMATCH[1]}"
        	repo="${BASH_REMATCH[2]}"
        	echo -e "\nYou entered an HTTPS URL."
        	echo "Converting it to SSH format..."
        	url="git@github.com:${user}/${repo}.git"
        	echo "Using SSH URL: $url"
        	sleep 1
    	fi

	if [[ ! "$url" =~ ^git@github.com:.+/.+\.git$ ]]; then
        	echo -e "\nInvalid URL format."
        	echo "Expected: git@github.com:username/repo.git"
		sleep 1
        	return 1
    	fi

	read -p "Enter project branch name: " branch
	echo -e "\nPushing..."
    	sleep 1

    	git remote add origin "$url" 2>/dev/null || git remote set-url origin "$url"

    	eval "$(ssh-agent -s)" >/dev/null 2>&1
    	found_key=false
    	for key in ~/.ssh/id_*; do
        	[[ "$key" =~ \.pub$ ]] && continue
        	ssh-add "$key" >/dev/null 2>&1
        	echo "Loaded key: $key"
        	found_key=true
    	done
    	if ! $found_key; then
        	echo -e "\nNo SSH key found! Generate one using:"
        	echo "ssh-keygen -t ed25519 -C 'your_email@example.com'"
        	return 1
    	fi

    	git branch -M "$branch"
    	git push -u origin "$branch"
    	if [ $? -ne 0 ]; then
		git_error
        	return 1
    	fi

    	echo -e "\nPush operation completed successfully!"
}

git_ssh_keygen(){
	read -p "Enter your GitHub email: " email
	echo -e "\nGenerating ssh key..."
	sleep 2
	ssh-keygen -t ed25519 -C $email
	if [ $? -ne 0 ]; then
		git_error
        fi
	echo -e "\nYour key should start with ssh-ed25519... And end-up with ...$email \nPlease copy it, as it is !"
	sleep 1
	echo -e "\nCopy the key below and add it into your 'GitHub Deploy key' from GitHub Settings"
	cat ~/.ssh/id_ed25519.pub

}

git_error(){
	echo -e "\nError occured! :( "
	sleep 1
        gitmaster
}

gitmaster


