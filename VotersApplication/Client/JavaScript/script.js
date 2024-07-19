function login(event) {
  const username = document.getElementById('username').value;
  const password = document.getElementById('password').value;
  const errorContainer = document.getElementById('errorContainer');

  errorContainer.innerHTML = '';

  if (username === '' && password === '') {
    errorContainer.innerHTML = 'Both username and password are required!';
  } else if (username === '') {
    errorContainer.innerHTML = 'Username is required!';
  } else if (password === '') {
    errorContainer.innerHTML = 'Password is required!';
  } else {
    $.ajax({
      type: 'POST',
      url: './../Server/login.php',
      data: { username: username, password: password },
      dataType: 'json',
      success: function (response) {
        if (response.success) {
          localStorage.setItem('userRole', response.role);

          window.location.href = 'votersPortal.html';

          document.getElementById('username').value = '';
          document.getElementById('password').value = '';
        } else {
          errorContainer.innerHTML = response.message;
        }
      },
      error: function (xhr, textStatus, errorThrown) {
        if (xhr.status === 401) {
          errorContainer.innerHTML = 'Invalid password';
        } else if (xhr.status === 404) {
          errorContainer.innerHTML = 'User not found';
        } else {
          alert('Error: ' + errorThrown);
        }
      },
    });
  }
}

function signup(event) {
  const username = document.getElementById('username').value;
  const password = document.getElementById('password').value;
  const confirmPassword = document.getElementById('confirmPassword').value;
  const role = document.querySelector('input[name="role"]:checked').value;

  const errorContainer = document.getElementById('errorContainer');

  errorContainer.innerHTML = '';

  if (!username || !password || !confirmPassword) {
    errorContainer.innerHTML = 'All fields are required.';
    return;
  }

  if (password.length < 6) {
    errorContainer.innerHTML = 'Password must be at least 6 characters.';
    return;
  }

  if (password !== confirmPassword) {
    errorContainer.innerHTML = 'Passwords do not match.';
    return;
  }

  if (!role) {
    errorContainer.innerHTML = 'Select a role.';
    return;
  }

  $.ajax({
    type: 'POST',
    url: './../Server/register.php',
    data: { username: username, password: password, role: role },
    dataType: 'json',
    success: function (response) {
      document.getElementById('username').value = '';
      document.getElementById('password').value = '';
      document.getElementById('confirmPassword').value = '';

      alert(response.message);
    },
    error: function (error) {
      console.log(error);
    },
  });
}

function addVoter() {
  const voterNameInput = document.getElementById('voterName');
  const voterdate_of_birth = document.getElementById('date_of_birth');
  const voterDescriptionInput = document.getElementById('address');
  const voterImageInput = document.getElementById('voterImage');
  const voterCouncilInput = document.getElementById('voterCouncil');
  const voterLocationInput = document.getElementById('voterPollingStation');

  
  const voterName = voterNameInput.value;
  const date_of_birth = voterdate_of_birth.value;
  const address = voterDescriptionInput.value;
  const voterImage = voterImageInput.files[0];
  const voterCouncil = voterCouncilInput.value;
  const voterPollingStation = voterLocationInput.value;
  console.log(voterName);
  console.log(date_of_birth);
  console.log(address);
  console.log(voterImage);
  console.log(voterCouncil);
  console.log(voterPollingStation);
  if (
    !voterName ||
    !date_of_birth ||
    !address ||
    !voterImage ||
    !voterCouncil ||
    !voterPollingStation
  ) {
    const errorContainer = document.getElementById('errorContainer');
    errorContainer.innerHTML = 'All fields are required';
    return;
  }

  const formData = new FormData();
  formData.append('voterName', voterName);
  formData.append('date_of_birth', date_of_birth);
  formData.append('address', address);
  formData.append('voterCouncil', voterCouncil);
  formData.append('voterPollingStation', voterPollingStation);
  formData.append('voterImage', voterImage);

  $.ajax({
    type: 'POST',
    url: './../Server/addVoter.php',
    data: formData,
    contentType: false,
    processData: false,
    success: function (response) {
      voterNameInput.value = '';
      voterdate_of_birth.value = '';
      voterDescriptionInput.value = '';
      voterImageInput.value = '';
      voterCouncilInput.value = '';
      voterLocationInput.value = '';
      alert('Voter added Successfully');
      const errorContainer = document.getElementById('errorContainer');
      errorContainer.innerHTML = '';
    },
    error: function (error) {
      const responseObj = JSON.parse(error.responseText);

      const errorContainer = document.getElementById('errorContainer');

      if (responseObj && responseObj.message) {
        errorContainer.innerHTML = responseObj.message;
      } else {
        errorContainer.innerHTML = 'An error occurred. Please try again.';
      }
      console.log(error);
    },
  });
}

function deleteVoter(voterId) {
  if (confirm('Are you sure you want to delete this voter?')) {
    const deletePromise = new Promise((resolve, reject) => {
      $.ajax({
        type: 'POST',
        url: './../Server/deleteVoter.php',
        data: { voterId: voterId },
        success: resolve,
        error: reject,
      });
    });

    deletePromise
      .then((response) => {
        location.reload(true);
      })
      .catch((error) => {
        console.error('Error during deletion:', error);
      });
  }
}

function openAdminPanel() {
  window.location.href = 'admin_panel.html';
}

function logout() {
  window.location.href = 'login.html';
  localStorage.clear();
}
