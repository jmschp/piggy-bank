const avatarActive = () => {
    const avatars = document.querySelectorAll('.avatar-bordered')
    avatars.forEach((avatar) => {
        avatar.addEventListener('click', (event) => {
            avatars.forEach((avatar) => {
                avatar.classList.remove("avatar-bordered-active");
            })
            event.currentTarget.classList.add("avatar-bordered-active");
        });
    });
}

export { avatarActive }