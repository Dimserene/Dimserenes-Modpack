#!/bin/bash

# Random Greeting Function
greet_user() {
    local greetings=(
        "Welcome back."
        "Initializing modpack update process."
        "Starting the update process."
        "Modpack update procedure starting."
        "Preparing to update modpacks."
        "Greetings, traveler! Ready to embark on an update journey?"
        "Ah, there you are! Let's get those modpacks updated."
        "Good day! Time to keep things up-to-date."
        "Hey there! Shall we freshen up your modpacks?"
        "Hello! The update realms await."
        "Salutations! Your mods have missed you."
        "Yo! Let's kickstart this update."
        "Howdy! Let's wrangle some updates."
        "Hiya! Ready for some mod magic?"
        "What's up? Time to get those mods in shape."
        "Welcome, esteemed user. The modpacks are at your command."
        "At your service! Let's proceed with the updates."
        "Greetings and salutations! Update initiation commencing."
        "Hello again! Let's make sure everything's shiny and new."
        "Welcome back, commander. Awaiting your update directives."
        "Good to see you! Let's bring everything up to speed."
        "Hey, it's update o'clock! Let's do this."
        "All systems nominal. Preparing updates."
        "Modpack update assistant ready for action."
        "Let's get this update party started!"
        "Back for more? Let's update those mods."
        "Your wish is my command. Starting updates."
        "Time flies! Let's make sure your mods do too."
        "Updating mods is my middle name. Let's go!"
        "The update train is leaving the station!"
        "Knock knock. Who's there? Updates!"
        "Brace yourself—updates are coming."
        "Feeling lucky? Let's roll out some updates."
        "It's a bird! It's a plane! No, it's an update!"
        "Did someone say updates? Oh wait, that was me."
        "Your mods called. They want to be updated."
        "Long time no see! Let's get those updates rolling."
        "The future is now. Updating to latest versions."
        "A wild updater appears! It's super effective."
        "Prepare yourself. Updates are imminent."
        "Welcome, hero! The modpacks await your command."
        "Good morning, sunshine! Time to update."
        "Evening, night owl! Let's get those mods updated."
        "Ahoy! Ready to set sail on the seas of updates?"
        "Top of the morning! Updates are brewing."
        "Let's make today extraordinary with some updates."
        "The update beacon is lit! Gondor calls for aid."
        "To update, or not to update? That is not a question."
        "Updates, updates everywhere! Let's grab some."
        "Modpack updates: because standing still is boring."
        "Welcome to the update dimension. Enjoy your stay."
        "Is it update time already? You bet it is!"
    )

local prepare_messages=(
        "Please wait while we prepare everything."
        "Hold on a moment while we get things ready."
        "Just a sec! Setting things up."
        "One moment please, preparing updates."
        "Hang tight, we're getting everything ready."
        "Setting the stage for updates, please wait."
        "Gearing up for updates, just a moment."
        "Preparing the update arena, standby."
        "Loading update modules, please hold on."
        "Your updates are being prepared, one moment."
        "Patience is a virtue! Prepping updates."
        "Give us a second to get things ready."
        "Almost there! Just setting up."
        "Wait a bit while we organize everything."
        "We're on it! Preparing things now."
        "Getting things in order, please wait."
        "Assembling the update tools."
        "Sharpening the update blades."
        "Calibrating modpack instruments."
        "Powering up the update engines."
        "Crafting the update flow, hang tight."
        "Fetching the latest update components."
        "Preparing the update battlefield."
        "Fine-tuning the modpack configurations."
        "Aligning the update stars, one moment."
        "Hold tight, magic is happening."
        "Working our update magic behind the scenes."
        "Finalizing preparations, please wait."
        "We're almost there! Getting things ready."
        "The update train is about to depart!"
        "Building the modpack universe, please wait."
        "Running pre-update diagnostics, hang on."
        "Spinning up the update wheels."
        "Prepping modpacks for the latest adventure."
        "Polishing the update gems, one sec."
        "The update cauldron is brewing, hold tight."
        "Fueling up for the update journey."
        "Warming up the update engines!"
        "The update orchestra is tuning up."
        "Running final checks, updates are near."
        "Please wait while we pull everything together."
        "Dusting off the update playbook."
        "Greasing the update gears."
        "The update elves are hard at work, please wait."
        "Kicking off the update sequence, stand by."
        "The update rocket is almost ready for launch."
        "Your updates are simmering, patience."
        "Hang tight while we work our update sorcery."
        "The update bot is assembling the parts."
        "Recharging the update batteries, please wait."
        "Your modpacks are about to evolve."
        "Configuring the ultimate update experience."
        "Getting the update wizards to work."
        "Stay tuned, updates are coming!"
        "Ready for an adventure? Preparing updates!"
        "The update train is departing shortly!"
        "Please bear with us, updating in progress."
        "Modifying the update scripts, one sec."
        "It won't be long now, just prepping updates."
        "Locking in the final update pieces."
        "Please be patient while we assemble the best update."
        "Connecting to the update server, please hold."
        "Update process is warming up, stay tuned."
        "Rolling out the update carpet, hang tight."
        "Final preparations for update launch."
        "Hold on! The update package is almost complete."
        "Your modpack adventure is about to begin!"
        "Finalizing the update structure, stay put."
        "Preparing your modpacks for greatness."
        "Your updates are downloading the latest awesomeness."
        "The update portal is opening soon!"
        "We're almost there, just setting things up."
        "Update ship is almost ready to sail!"
        "Hold tight, modpack magic incoming."
        "Your updates are ready for liftoff!"
    )

    local greeting_index=$((RANDOM % ${#greetings[@]}))
    local prepare_index=$((RANDOM % ${#prepare_messages[@]}))
    echo ""
    echo ""
    echo ""
    echo ""
    echo "${greetings[$greeting_index]}"
    echo "${prepare_messages[$prepare_index]}"
    echo ""
    sleep 1  # Added sleep and extra line
}

# Random Progress Messages
update_message() {
    local updates=(
        "Checking for the latest updates."
        "Processing modpack updates."
        "Verifying modpack versions."
        "Applying available updates."
        "Updating the modpacks now."
        "Synchronizing with the mod universe."
        "Fetching the freshest mods just for you."
        "Scanning for mod enhancements."
        "Engaging update protocols."
        "Deploying new modpack features."
        "Inserting updates into the mod matrix."
        "Hold tight! We're modernizing your mods."
        "Brewing some fresh updates."
        "Revving up the update engine."
        "Cooking up the latest mod recipes."
        "Polishing mods to perfection."
        "Injecting awesomeness into your modpacks."
        "Channeling update energies."
        "Modifying mods with the newest tweaks."
        "Downloading modpack awesomeness."
        "Wrapping up the update bundle."
        "Aligning modpack versions."
        "Weeding out outdated mods."
        "Cultivating new mod growth."
        "Stitching together mod updates."
        "Elevating your mod experience."
        "Charging the update lasers."
        "Mapping out mod dependencies."
        "Fine-tuning mod configurations."
        "Gathering modpack intelligence."
        "Commencing modpack rejuvenation."
        "Reinforcing modpack integrity."
        "Enriching mods with new content."
        "Streaming updates from the source."
        "Reloading mod assets."
        "Spicing up your mods with new flavors."
        "Blending in the latest mod ingredients."
        "Collecting modpack artifacts."
        "Boosting mod performance."
        "Unlocking new mod features."
        "Rewriting mod histories."
        "Sailing the seas of updates."
        "Diving deep into mod code."
        "Orchestrating mod symphonies."
        "Upgrading modpack infrastructure."
        "Transforming mods to their latest forms."
        "Activating update sequences."
        "Embracing change with mod updates."
        "Infusing mods with cutting-edge tech."
        "Recharging mod energies."
        "Revitalizing your mod collections."
        "Navigating the update labyrinth."
        "Illuminating the path to updates."
        "Maximizing mod potential."
        "Empowering mods with new abilities."
        "Sculpting mods into masterpieces."
        "Elevating mods to new heights."
        "Sharpening the edge of your mods."
        "Transcending mod limitations."
        "Enhancing gameplay with fresh mods."
        "Expanding mod horizons."
        "Reinventing mods for you."
        "Synchronizing with the mod network."
        "Enabling next-gen mod features."
        "Harvesting updates from the mod fields."
        "Rewriting the mod playbook."
        "Fortifying mods against bugs."
        "Empowering your mods with updates."
        "Embarking on a mod update quest."
        "Recalibrating mod settings."
        "Adapting mods to new standards."
        "Unleashing updated modpacks."
        "Modpacks are leveling up."
        "Initializing mod evolution."
        "Sprinkling magic on your mods."
        "Laying down new mod foundations."
        "Constructing updated mod worlds."
        "Blasting off into mod updates."
        "Bridging the gap to new mods."
        "Revamping mod architectures."
        "Streaming modpack enhancements."
        "Igniting the update spark."
        "Setting mods to hyperdrive."
        "Modding the mods with updates."
        "Downloading awesomeness."
        "Reviving mods with fresh code."
        "Reimagining your modpacks."
        "Reloading mod canons."
        "Traversing the mod multiverse."
        "Purifying mod codebases."
        "Recharging the mod batteries."
        "Seeding mods with innovations."
        "Upgrading mods to over 9000!"
        "Cycling through update phases."
        "Weaving updates into mods."
        "Modpacks are metamorphosing."
        "Constructing mod skyscrapers."
        "Scaling the peaks of updates."
        "Planting seeds of mod greatness."
        "Unveiling the latest mod secrets."
        "Unfolding new mod dimensions."
        "Lifting mods to the cloud."
        "Pioneering new mod territories."
        "Animating mod updates."
        "Bringing mods into the future."
        "Quantum updating in progress."
        "Charging up the mod circuits."
        "Teleporting updates into mods."
        "Integrating updates seamlessly."
    )
    
    local update_index=$((RANDOM % ${#updates[@]}))
    echo "${updates[$update_index]}"
}

# Random Exit Message
exit_message() {
    local farewells=(
        "Update process completed successfully."
        "All modpacks are up to date."
        "The update procedure has finished."
        "Modpacks updated successfully."
        "Modpack updates applied without issues."
        "Mission accomplished. Mods are updated."
        "You're all set! Enjoy your mods."
        "Everything's shiny. Not to fret."
        "Updates complete. Happy gaming!"
        "All systems updated and operational."
        "Mods have been refreshed. Have fun!"
        "Updates installed. Adventure awaits!"
        "Your mods thank you for the update."
        "Success! Mods are now current."
        "Update journey concluded. Farewell!"
        "Mods have evolved to their latest forms."
        "Update sequence finished flawlessly."
        "Modpacks are now in peak condition."
        "Updates applied. The future is now."
        "All done here. Time to play!"
        "Mods are as good as new."
        "Update complete. You're good to go."
        "The mod gods are pleased."
        "Modpacks have been supercharged."
        "Operation update is a success."
        "Updates locked and loaded."
        "Mods updated. The realm is secure."
        "You're updated and ready to rock."
        "Mods are current. Game on!"
        "Update wrap-up complete."
        "Finished updating. Enjoy the enhancements."
        "Mods have been uplifted."
        "Your modpacks are in tip-top shape."
        "All mods are now synchronized."
        "Update process went smoothly."
        "Mods updated without a hitch."
        "The updates have landed."
        "Mods have been polished and primed."
        "Updates have been seamlessly integrated."
        "Your mods are at their finest."
        "Update mission complete."
        "The mod universe is now aligned."
        "Mods are updated. The journey continues."
        "All updates are now in place."
        "Mods have been rejuvenated."
        "Success! Mods are at peak performance."
        "Updates have fortified your mods."
        "Modpacks are now future-proof."
        "Update marathon finished."
        "Mods have reached enlightenment."
        "Updates concluded. Until next time."
        "Modpacks are now up to spec."
        "Your modpacks are update champions."
        "Mods have been reloaded."
        "Update voyage has been a success."
        "Modpacks are now shining bright."
        "All mods are now harmonized."
        "Updates have been gracefully applied."
        "Mods are refreshed and ready."
        "Mod update dance is over."
        "Mods have been enhanced significantly."
        "Update odyssey complete."
        "Your mods have ascended."
        "Mods have been upgraded exquisitely."
        "Update saga has reached its end."
        "Mods stand ready for action."
        "Update symphony has concluded."
        "Mods are now top-tier."
        "Update triumph achieved."
        "Mods are now in elite status."
        "Modpacks have been refined."
        "Update festival has ended."
        "Mods have been enriched."
        "Your mods are now legendary."
        "Update quest completed successfully."
        "Mods are at maximum potential."
        "The circle of updates is complete."
        "Mods are now in optimal condition."
        "Update magic has been cast."
        "Mods have reached their zenith."
        "Update summit achieved."
        "Mods are fully operational."
        "Update wave has passed."
        "Mods are now exemplary."
        "Update frontier has been conquered."
        "Mods have been revitalized."
        "Update rollercoaster has stopped."
        "Mods are in harmony."
        "Update crescendo has been played."
        "Mods have blossomed."
        "Update chapter closed."
        "Mods are primed and ready."
        "Update realm has been explored."
        "Mods have been perfected."
        "Update masterpiece completed."
        "Mods are now unparalleled."
        "Update journey has been fulfilled."
        "Mods have been optimized."
        "Update horizon reached."
        "Mods stand updated and victorious."
    )
    
    local farewell_index=$((RANDOM % ${#farewells[@]}))
    echo "${farewells[$farewell_index]}"
}

# Random Exit Quotes when 'q' is pressed
exit_quote() {
    local quotes=(
        "Exiting... See you next time!"
        "Goodbye! Your work here is done."
        "Farewell! Until we meet again."
        "Thank you for using the update script!"
        "Leaving so soon? Take care!"
        "Adieu! May your mods be ever updated."
        "Catch you later! Stay modded."
        "So long, and thanks for all the fish."
        "Bye! Don't be a stranger."
        "See ya! Keep on modding."
        "It's been real. Peace out!"
        "Over and out. Happy trails!"
        "Off you go! Mods will miss you."
        "Safe travels! Until next update."
        "Ta-ta for now! Mods await your return."
        "Goodbye! May your code compile."
        "Exiting stage left. Break a leg!"
        "Time to say goodbye. Live long and prosper."
        "Farewell! May the force be with you."
        "Adios! Keep calm and mod on."
        "Parting is such sweet sorrow."
        "Until next time, happy gaming!"
        "Closing up shop. See you soon!"
        "Exit initiated. Have a great day!"
        "Logging off. Catch you on the flip side!"
        "Signing out. Stay awesome!"
        "Time to vanish. Mods are standing by."
        "You've pressed 'q'. Quest over."
        "Disengaging. Mods will be here."
        "Shutting down. Remember to update!"
        "Bye-bye! Don't forget to smile."
        "So long! Keep those mods updated."
        "Exiting the mod realm. Farewell!"
        "Leaving already? Mods await."
        "It's been a pleasure. Take care!"
        "Au revoir! Until we code again."
        "Hasta la vista, baby!"
        "Ciao! May your mods be bug-free."
        "Godspeed! Adventure awaits."
        "Toodle-oo! Stay curious."
        "Departure confirmed. All the best!"
        "Going offline. Mods are paused."
        "End of line. Be well!"
        "Exiting the matrix. Follow the white rabbit."
        "Time to bounce. Keep it real!"
        "Logging out. See you in the next session!"
        "Ejecting... Mods will wait."
        "Farewell, friend. Mods salute you."
        "Disappearing into the void."
        "The end is nigh. Until next time."
        "Off to infinity and beyond!"
        "Exiting quietly. No errors found."
        "Waving goodbye. Mods out."
        "Shutting the gates. Safe journeys!"
        "Curtain call. Encore another time."
        "Departing now. Keep exploring!"
        "See you later, alligator!"
        "After a while, crocodile!"
        "Time flies. Gotta run!"
        "Exiting. May your day be great."
        "Heading out. Keep the mods alive."
        "Signing off. Until another day."
        "Farewell! Mods will be here."
        "Closing connection. Stay connected!"
        "May your updates be swift and your bugs few."
        "Time to part ways. Keep coding!"
        "Leaving the mod station. All aboard next time!"
        "Bon voyage! Until we update again."
        "Off like a rocket! Mods in orbit."
        "Exiting the updater. Mods standing by."
        "The adventure ends here. For now."
        "Adventurer, you are always welcome."
        "Terminating session. Mods saved."
        "Escape pressed. Exiting the loop."
        "End of the road. Until we meet again."
        "Departing. Mods await your return."
        "Exiting the realm. The mods rest."
        "Stepping away. Mods on standby."
        "Signing out. Your mods thank you."
        "Time to split. Stay awesome!"
        "It's closing time. You don't have to go home..."
        "Finishing up. Mods powered down."
        "Exiting. May your code be clean."
        "Mission abort. Exiting safely."
        "Retreating. Mods will hold the line."
        "Disconnecting. See you next session!"
        "Powering down. Mods in sleep mode."
        "Leaving the terminal. Keep hacking!"
        "End transmission. Over and out."
        "Fare thee well. Mods at rest."
        "Exiting application. Mods secured."
        "Time's up! See you around."
        "Press any key to continue... Just kidding. Bye!"
        "Ceasing operations. Mods archived."
    )
    
    local quote_index=$((RANDOM % ${#quotes[@]}))
    echo "${quotes[$quote_index]}"
}

# Random Selection Prompts
selection_prompt() {
    local prompts=(
        "Select the modpacks you wish to update:"
        "Choose which modpacks to update:"
        "Pick the modpacks to update:"
        "Indicate the modpacks to update:"
        "Please specify which modpacks to update:"
        "Which modpacks would you like to refresh?"
        "Point out the modpacks for updating:"
        "Time to select your modpacks for updates:"
        "Your choice: Which modpacks need updates?"
        "Let us know which modpacks to work on:"
        "Decide on the modpacks to update:"
        "Select your desired modpacks:"
        "Choose your modpacks wisely:"
        "Nominate modpacks for updating:"
        "Identify modpacks to update:"
        "Ready to update? Pick your modpacks:"
        "List the modpacks you want to update:"
        "Specify modpacks for the update:"
        "Time to update! Which modpacks?"
        "State the modpacks to refresh:"
        "Tell me, which modpacks shall we update?"
        "Your call: Which modpacks need attention?"
        "Choose your update targets:"
        "Select the modpacks for the mission:"
        "Which modpacks are due for updates?"
        "Highlight modpacks for updating:"
        "Mark the modpacks you'd like to update:"
        "It's update time! Select modpacks:"
        "Ready to roll? Pick your modpacks:"
        "Which modpacks shall receive the update?"
        "Assign modpacks for the update task:"
        "Handpick modpacks for updating:"
        "Designate modpacks for refresh:"
        "Make your selection of modpacks:"
        "Which modpacks are on your update list?"
        "Identify the modpacks needing updates:"
        "Let’s get started! Choose modpacks:"
        "Your mission: Update which modpacks?"
        "Direct me to the modpacks to update:"
        "Point me to the modpacks needing updates:"
        "Select modpacks for the update journey:"
        "Prepare to update! Which modpacks?"
        "Which modpacks are on the agenda?"
        "Decide which modpacks to enhance:"
        "Pick out modpacks for the upgrade:"
        "Determine the modpacks to update:"
        "Let’s upgrade! Select modpacks:"
        "Choose modpacks for a new shine:"
        "Time to upgrade! Which modpacks?"
        "Select modpacks to bring up to date:"
        "Elect modpacks for the update process:"
        "Name the modpacks to be updated:"
        "Shall we proceed? Choose modpacks:"
        "Your selection: Which modpacks?"
        "Opt for modpacks to update:"
        "Modpacks awaiting updates. Select:"
        "Which modpacks need some love?"
        "Update selection: Choose modpacks:"
        "Pick and choose your modpacks:"
        "Step right up! Select modpacks:"
        "Select the modpacks calling for updates:"
        "The choice is yours: Modpacks to update:"
        "Ready, set, update! Which modpacks?"
        "Let's make it happen! Choose modpacks:"
        "Select the modpacks to get updates:"
        "Your turn! Which modpacks to update?"
        "Time to act! Pick modpacks:"
        "Select the lucky modpacks:"
        "Identify your chosen modpacks:"
        "Choose now: Which modpacks?"
        "Modpack selection time! Go ahead:"
        "Take your pick of modpacks:"
        "Which modpacks will it be today?"
        "Decide now: Update which modpacks?"
        "Let's do this! Select modpacks:"
        "The update awaits. Choose modpacks:"
        "It's your call: Which modpacks?"
        "Select modpacks to receive updates:"
        "Make a choice: Modpacks to update:"
        "Pick your contenders for updates:"
        "Specify your modpack choices:"
        "Choose the modpacks for action:"
        "Name your modpacks for updating:"
        "Select modpacks to power up:"
        "Choose modpacks to advance:"
        "Ready for updates? Pick modpacks:"
        "Identify modpacks for the upgrade:"
        "Select modpacks for enhancement:"
        "Which modpacks are you eyeing?"
        "Highlight your modpack selections:"
        "Make your move: Select modpacks:"
        "Choose wisely: Modpacks to update:"
        "Select the modpacks to be renewed:"
        "Let's refresh! Pick modpacks:"
        "Your input needed: Which modpacks?"
        "Decide the modpacks for this update:"
        "Update time! Which modpacks to choose?"
        "Select the modpacks awaiting refresh:"
        "Nominate your modpacks for updates:"
        "Pick modpacks to get the latest:"
    )
    
    local prompt_index=$((RANDOM % ${#prompts[@]}))
    echo "${prompts[$prompt_index]}"
}

# Random Input Error Message
input_error_message() {
    local errors=(
        "Invalid input, please try again."
        "That selection is not valid."
        "Input not recognized, please retry."
        "Unrecognized input, please correct it."
        "Input error, please enter a valid option."
        "Oops! That doesn't look right."
        "Hmm, that input seems off. Try again."
        "Error: Input not acceptable."
        "Uh-oh, invalid choice. Please re-enter."
        "Sorry, that's not a valid selection."
        "Let's try that again with proper input."
        "Invalid entry detected."
        "Please provide a valid selection."
        "That input won't work. Give it another go."
        "Input error: Please check your selection."
        "Hold on, that's not an option."
        "Incorrect input, please choose again."
        "Invalid choice, let's try once more."
        "Nope, that's not it. Try again."
        "I didn't catch that. Please re-enter."
        "Your selection is out of bounds."
        "That's not a choice we can use."
        "Error: Please enter a valid response."
        "That doesn't compute. Try again."
        "Input not valid, please select properly."
        "Selection error, please input correctly."
        "Hmm, that's not on the list."
        "Invalid command, please retry."
        "Your input seems incorrect."
        "Not a valid input. Let's retry."
        "Input rejected, please try again."
        "I need a valid option, please."
        "Let's go back and pick a valid option."
        "Selection not recognized."
        "That's not one of the options."
        "Error: Unacceptable input."
        "Invalid. Please select from the options."
        "Input error: Option not found."
        "Please choose a valid number or range."
        "Invalid input detected. Try again."
        "Sorry, that's not acceptable."
        "Hmm, I don't think that's correct."
        "Oops, please enter a valid selection."
        "Unrecognized selection, please retry."
        "Invalid choice, please try once more."
        "That doesn't seem right. Try again."
        "Let's stick to the options provided."
        "Error: Invalid entry."
        "That input isn't valid."
        "Please input a correct selection."
        "We couldn't process that input."
        "Invalid selection, give it another shot."
        "Not quite. Please try again."
        "Your input doesn't match any options."
        "Please provide a proper input."
        "Error: Selection out of range."
        "That choice isn't available."
        "Input invalid. Please try again."
        "Invalid entry. Let's retry."
        "Hmm, that's not valid."
        "Please enter a correct option."
        "I didn't understand that input."
        "Selection error. Try again."
        "Invalid input. Please choose correctly."
        "Oops! Let's pick a valid option."
        "Sorry, that's not on the menu."
        "Your selection is invalid."
        "Let's have another go at that input."
        "Error: Incorrect selection."
        "Not a valid choice. Please retry."
        "Please choose a valid option."
        "Input not acceptable. Try again."
        "That doesn't match any options."
        "Invalid input. Let's try again."
        "Please enter a valid choice."
        "Hmm, that doesn't seem right."
        "Unacceptable input. Please re-enter."
        "Selection invalid. Please retry."
        "I can't process that input."
        "Input error. Please provide a valid selection."
        "Let's stick to the valid options."
        "Invalid option selected."
        "Please choose from the listed options."
        "That input won't do. Try again."
        "Selection not valid. Please retry."
        "Error: Invalid choice."
        "Your input doesn't compute."
        "Please re-enter a valid selection."
        "Not an option. Please try again."
        "Invalid selection detected."
        "Let's input something valid this time."
        "Error: Input not within options."
        "That selection isn't recognized."
        "Please enter a correct number or range."
        "Input error. Let's go again."
        "Invalid choice. Please re-enter."
        "Oops! That's not correct."
        "Let's pick a valid input this time."
        "Selection error. Please choose properly."
        "Invalid input received."
        "Please input a valid selection."
    )
    
    local error_index=$((RANDOM % ${#errors[@]}))
    echo "${errors[$error_index]}"
}

# Base path
base_path=/sdcard/Modpacks
modpacks_list="$base_path/modpacks_list.txt"

# Load modpacks dynamically from a file
modpacks=()
if [[ -f "$modpacks_list" ]]; then
    while IFS= read -r line; do
        # Trim leading/trailing whitespace and skip empty lines
        trimmed_line=$(echo "$line" | xargs)
        if [[ -n "$trimmed_line" ]]; then
            modpacks+=("$trimmed_line")
        fi
    done < "$modpacks_list"
else
    echo "Error: $modpacks_list not found."
    exit 1
fi

# Log file path
log_file="$base_path/update_log.txt"

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'  # No color

# Enhanced log_status function with color support
log_status() {
    local modpack=$1
    local status=$2
    local color
    local display_status

    # Determine color based on status
    case "$status" in
        *"SUCCESS"*)
            color=$GREEN
            display_status="SUCCESS"
            ;;
        *"FAILED"*)
            color=$RED
            display_status="FAILED"
            ;;
        *"SKIPPED"*)
            color=$YELLOW
            display_status="SKIPPED"
            ;;
        *)
            color=$NC
            display_status="$status"
            ;;
    esac

    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    local message="[$timestamp] ${modpack} update: ${display_status}"

    # Print the message to the console with color
    echo -e "${color}${message}${NC}"
    
    # Log the message to the log file without color
    echo "$message" >> "$log_file"
    
    # Add the message to the execution summary
    execution_summaries+=("$modpack: $display_status")
}

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'  # No Color

update_modpack() {
    local modpack=$1
    local modpack_path="$base_path/$modpack"

    if [[ ! -d "$modpack_path" ]]; then
        log_status "$modpack" "FAILED (Directory does not exist)"
        return 1
    fi

    # Choose a consistent phrase for the update
    local phrase="Updating"
    show_progress "$phrase" &
    spinner_pid=$!

    if [[ ! -f "$modpack_path/autoversion.sh" ]]; then
        log_status "$modpack" "FAILED (autoversion.sh not found)"
        kill "$spinner_pid"
        return 1
    fi

    cd "$modpack_path" || exit

    # Run the update script and capture the output step-by-step
    echo -e "\n\033[0;36mRunning autoversion.sh for $modpack...\033[0m"
    sh "$modpack_path/autoversion.sh" 2>&1 | while IFS= read -r line; do
        echo -e "\033[0;34m$line\033[0m"  # Output each line in blue color for clarity
    done

    # Check the status of the script execution
    if [[ ${PIPESTATUS[0]} -eq 0 ]]; then
        kill "$spinner_pid"
        echo -e "\n\033[0;32m$modpack: SUCCESS\033[0m"  # Success in green
        log_status "$modpack" "SUCCESS"
    else
        kill "$spinner_pid"
        echo -e "\n\033[0;31m$modpack: FAILED (Check autoversion.sh output for details)\033[0m"  # Failure in red
        log_status "$modpack" "FAILED (Check autoversion.sh output for details)"
        return 1
    fi
}

# Progress function with consistent phrase per modpack update
show_progress() {
    local -a spinner=('䷀' '䷪' '䷍' '䷡' '䷈' '䷄' '䷙' '䷊' '䷉' '䷹' '䷥' '䷵' '䷼' '䷻' '䷨' '䷒' '䷌' '䷰' '䷝' '䷶' '䷤' '䷾' '䷕' '䷣' '䷘' '䷐' '䷔' '䷲' '䷩' '䷂' '䷚' '䷗' '䷁' '䷖' '䷇' '䷓' '䷏' '䷢' '䷬' '䷋' '䷎' '䷳' '䷦' '䷴' '䷽' '䷷' '䷞' '䷠' '䷆' '䷃' '䷜' '䷺' '䷧' '䷿' '䷮' '䷅' '䷭' '䷑' '䷯' '䷸' '䷟' '䷱' '䷛' '䷫')
    local delay=0.1

    # Select one consistent phrase per modpack update
    local phrases=(
        "Initializing"
        "Fetching data"
        "Updating"
        "Applying changes"
        "Loading resources"
        "Synchronizing"
    )

    # Randomly choose a phrase to use for the entire update
    local phrase="${phrases[$((RANDOM % ${#phrases[@]}))]}"
    local dots=""

    while true; do
        for s in "${spinner[@]}"; do
            # Extend trailing dots up to a limit
            dots="${dots}."
            if [[ ${#dots} -gt 6 ]]; then
                dots="..."
            fi

            # Clear the line, print spinner, and phrase with dots
            printf "\r\033[K%s %s%s" "$s" "$phrase" "$dots"
            
            # Sleep for a short period before updating
            sleep "$delay"
        done
    done
}

validate_input() {
    local input=$1
    if [[ ! "$input" =~ ^[0-9]+$ ]]; then
        log_status "Input Validation" "FAILED (Invalid input: $input)"
        input_error_message
        return 1
    fi
    return 0
}

# Function to select modpacks
select_modpacks() {
    while true; do
        echo "================================="
        selection_prompt  # Random selection prompt
        echo "(e.g., 1 2 4-5 or 1-3 5)"
        echo ""
        for i in "${!modpacks[@]}"; do
            echo "$((i+1)). ${modpacks[i]}"
        done
        echo ""
        echo "a. Update all modpacks"
        echo "q. Cancel and exit"
        echo "================================="

        local input_prompts=(
            "Enter your selection: "
            "Please choose an option: "
            "Make your selection: "
            "Choose your desired option: "
            "Select your option: "
            "Go ahead, pick a number: "
            "Your choice, please: "
            "What would you like to do? "
            "It's your move, enter your choice: "
            "Type your selection: "
            "Which option will it be? "
            "Decide now, enter your selection: "
            "Time to pick! Enter your selection: "
            "Select a number and hit enter: "
            "Enter your preferred option: "
            "Make your move, choose an option: "
            "Please type the number of your choice: "
            "Go ahead and make your selection: "
            "Your call, enter the number: "
            "Pick a number to proceed: "
            "What’s your choice? Enter now: "
            "Type the number of your chosen option: "
            "Select from the list above: "
            "Ready? Pick your option: "
            "Your turn! Enter your choice: "
            "Please provide your input: "
            "Time to decide, pick a number: "
            "Choose wisely! Enter your selection: "
            "What’s your decision? Type it here: "
            "Type your choice and hit enter: "
            "Which path will you take? Pick an option: "
            "Your journey begins! Pick a number: "
            "The choice is yours! Enter a number: "
            "Input your choice and press enter: "
            "Your adventure awaits! Choose an option: "
            "Select the path forward by typing a number: "
            "Which way will you go? Enter your selection: "
            "Decision time! Enter your selection: "
            "Your input, please: "
            "What’s next? Choose an option: "
            "Type your decision here: "
            "Pick a number from the list: "
            "Let’s go! What’s your choice? "
            "Choose your option from the menu: "
            "Select your path by entering a number: "
            "What’s your move? Enter it now: "
            "Input your selection to continue: "
            "Pick a number to advance: "
            "Make your decision: "
            "Your choice determines the next step! Pick wisely: "
            "Let’s keep things rolling! Enter your choice: "
            "Select an option to proceed: "
            "Where will you go from here? Pick a number: "
            "Lock in your choice by entering a number: "
            "Onward! What’s your next move? "
            "The next step is yours! Type your choice: "
            "Take your pick and let’s proceed: "
            "Ready to move forward? Enter a number: "
            "Which option do you prefer? Type it here: "
            "The choice is yours! Enter a number: "
            "Make your mark! Pick a number: "
            "Chart your course! Choose an option: "
            "What’s your game plan? Type your choice: "
            "Go ahead and pick your number: "
            "Your selection determines the course! Pick wisely: "
        )

        local prompt_index=$((RANDOM % ${#input_prompts[@]}))
        read -p "${input_prompts[$prompt_index]}" choice

        # Check if input is 'q' or 'a' before number/range validation
        if [[ "$choice" == "q" ]]; then
            exit_quote  # Random exit quote
            sleep 1  # Wait 1 second before exiting
            log_status "User Action" "Exited the script."
            exit 0
        elif [[ "$choice" == "a" ]]; then
            selected_modpacks=("${modpacks[@]}")
            break
        fi

        selected_modpacks=()
        valid_input=true

        # Split choice into individual selections
        IFS=' ' read -r -a choice_array <<< "$choice"

        # Validate each selection
        for item in "${choice_array[@]}"; do
            if [[ "$item" =~ ^[0-9]+-[0-9]+$ ]]; then
                start=$(echo "$item" | cut -d '-' -f 1)
                end=$(echo "$item" | cut -d '-' -f 2)
                if [[ "$start" -ge 1 && "$end" -le "${#modpacks[@]}" && "$start" -le "$end" ]]; then
                    for ((i=start; i<=end; i++)); do
                        selected_modpacks+=("${modpacks[$((i-1))]}")
                    done
                else
                    input_error_message
                    log_status "Range Selection" "FAILED (Invalid range: $item)"
                    valid_input=false
                    break
                fi
            elif [[ "$item" =~ ^[0-9]+$ ]]; then
                if [[ "$item" -ge 1 && "$item" -le "${#modpacks[@]}" ]]; then
                    selected_modpacks+=("${modpacks[$((item-1))]}")
                else
                    input_error_message
                    log_status "Selection" "FAILED (Invalid selection: $item)"
                    valid_input=false
                    break
                fi
            else
                input_error_message
                log_status "Selection" "FAILED (Invalid input: $item)"
                valid_input=false
                break
            fi
        done
        
        # Break the loop if input was valid
        if $valid_input; then
            break
        fi
    done
}
        

# Main Execution
execution_summaries=()

# Greet the user with a random message
greet_user

# Select modpacks for updating
select_modpacks

# Update selected modpacks
for modpack in "${selected_modpacks[@]}"; do
    update_message  # Random update message
    update_modpack "$modpack"
done

# Display summary of results
echo ""
echo "================================="
echo "Update Summary:"
for summary in "${execution_summaries[@]}"; do
    echo "$summary"
    log_status "Update Summary" "$summary"
done
echo "================================="

# Final script completion log
log_status "Script Execution" "Completed successfully."

# Display a random exit message
exit_message

# Prompt user to press enter to exit
echo ""
echo "Press enter to exit..."
read -r  # Changed to wait for enter key