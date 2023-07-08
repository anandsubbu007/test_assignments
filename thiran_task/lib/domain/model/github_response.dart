class GithubResponse {
  final dynamic totalCount;
  final bool? incompleteResults;
  final List<Items>? items;

  GithubResponse({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  GithubResponse.fromJson(Map<String, dynamic> json)
      : totalCount = json['total_count'] as dynamic,
        incompleteResults = json['incomplete_results'] as bool?,
        items = (json['items'] as List?)
            ?.map((dynamic e) => Items.fromJson(e as Map<String, dynamic>))
            .toList();
}

class Items {
  final dynamic id;
  final String? nodeId;
  final String? name;
  final String? fullName;
  final bool? private;
  final Owner? owner;
  final String? htmlUrl;
  final String? description;
  final bool? fork;
  final String? url;
  final String? forksUrl;
  final String? keysUrl;
  final String? collaboratorsUrl;
  final String? teamsUrl;
  final String? hooksUrl;
  final String? issueEventsUrl;
  final String? eventsUrl;
  final String? assigneesUrl;
  final String? branchesUrl;
  final String? tagsUrl;
  final String? blobsUrl;
  final String? gitTagsUrl;
  final String? gitRefsUrl;
  final String? treesUrl;
  final String? statusesUrl;
  final String? languagesUrl;
  final String? stargazersUrl;
  final String? contributorsUrl;
  final String? subscribersUrl;
  final String? subscriptionUrl;
  final String? commitsUrl;
  final String? gitCommitsUrl;
  final String? commentsUrl;
  final String? issueCommentUrl;
  final String? contentsUrl;
  final String? compareUrl;
  final String? mergesUrl;
  final String? archiveUrl;
  final String? downloadsUrl;
  final String? issuesUrl;
  final String? pullsUrl;
  final String? milestonesUrl;
  final String? notificationsUrl;
  final String? labelsUrl;
  final String? releasesUrl;
  final String? deploymentsUrl;
  final String? createdAt;
  final String? updatedAt;
  final String? pushedAt;
  final String? gitUrl;
  final String? sshUrl;
  final String? cloneUrl;
  final String? svnUrl;
  final dynamic homepage;
  final dynamic size;
  final int? stargazersCount;
  final dynamic watchersCount;
  final String? language;
  final bool? hasIssues;
  final bool? hasProjects;
  final bool? hasDownloads;
  final bool? hasWiki;
  final bool? hasPages;
  final bool? hasDiscussions;
  final dynamic forksCount;
  final dynamic mirrorUrl;
  final bool? archived;
  final bool? disabled;
  final dynamic openIssuesCount;
  final License? license;
  final bool? allowForking;
  final bool? isTemplate;
  final bool? webCommitSignoffRequired;
  final List<dynamic>? topics;
  final String? visibility;
  final dynamic forks;
  final dynamic openIssues;
  final dynamic watchers;
  final String? defaultBranch;
  final dynamic score;

  Items({
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
    this.private,
    this.owner,
    this.htmlUrl,
    this.description,
    this.fork,
    this.url,
    this.forksUrl,
    this.keysUrl,
    this.collaboratorsUrl,
    this.teamsUrl,
    this.hooksUrl,
    this.issueEventsUrl,
    this.eventsUrl,
    this.assigneesUrl,
    this.branchesUrl,
    this.tagsUrl,
    this.blobsUrl,
    this.gitTagsUrl,
    this.gitRefsUrl,
    this.treesUrl,
    this.statusesUrl,
    this.languagesUrl,
    this.stargazersUrl,
    this.contributorsUrl,
    this.subscribersUrl,
    this.subscriptionUrl,
    this.commitsUrl,
    this.gitCommitsUrl,
    this.commentsUrl,
    this.issueCommentUrl,
    this.contentsUrl,
    this.compareUrl,
    this.mergesUrl,
    this.archiveUrl,
    this.downloadsUrl,
    this.issuesUrl,
    this.pullsUrl,
    this.milestonesUrl,
    this.notificationsUrl,
    this.labelsUrl,
    this.releasesUrl,
    this.deploymentsUrl,
    this.createdAt,
    this.updatedAt,
    this.pushedAt,
    this.gitUrl,
    this.sshUrl,
    this.cloneUrl,
    this.svnUrl,
    this.homepage,
    this.size,
    this.stargazersCount,
    this.watchersCount,
    this.language,
    this.hasIssues,
    this.hasProjects,
    this.hasDownloads,
    this.hasWiki,
    this.hasPages,
    this.hasDiscussions,
    this.forksCount,
    this.mirrorUrl,
    this.archived,
    this.disabled,
    this.openIssuesCount,
    this.license,
    this.allowForking,
    this.isTemplate,
    this.webCommitSignoffRequired,
    this.topics,
    this.visibility,
    this.forks,
    this.openIssues,
    this.watchers,
    this.defaultBranch,
    this.score,
  });

  Items.fromJson(Map<String, dynamic> json)
      : id = json['id'] as dynamic,
        nodeId = json['node_id'] as String?,
        name = json['name'] as String?,
        fullName = json['full_name'] as String?,
        private = json['private'] as bool?,
        owner = (json['owner'] as Map<String, dynamic>?) != null
            ? Owner.fromJson(json['owner'] as Map<String, dynamic>)
            : null,
        htmlUrl = json['html_url'] as String?,
        description = json['description'],
        fork = json['fork'] as bool?,
        url = json['url'] as String?,
        forksUrl = json['forks_url'] as String?,
        keysUrl = json['keys_url'] as String?,
        collaboratorsUrl = json['collaborators_url'] as String?,
        teamsUrl = json['teams_url'] as String?,
        hooksUrl = json['hooks_url'] as String?,
        issueEventsUrl = json['issue_events_url'] as String?,
        eventsUrl = json['events_url'] as String?,
        assigneesUrl = json['assignees_url'] as String?,
        branchesUrl = json['branches_url'] as String?,
        tagsUrl = json['tags_url'] as String?,
        blobsUrl = json['blobs_url'] as String?,
        gitTagsUrl = json['git_tags_url'] as String?,
        gitRefsUrl = json['git_refs_url'] as String?,
        treesUrl = json['trees_url'] as String?,
        statusesUrl = json['statuses_url'] as String?,
        languagesUrl = json['languages_url'] as String?,
        stargazersUrl = json['stargazers_url'] as String?,
        contributorsUrl = json['contributors_url'] as String?,
        subscribersUrl = json['subscribers_url'] as String?,
        subscriptionUrl = json['subscription_url'] as String?,
        commitsUrl = json['commits_url'] as String?,
        gitCommitsUrl = json['git_commits_url'] as String?,
        commentsUrl = json['comments_url'] as String?,
        issueCommentUrl = json['issue_comment_url'] as String?,
        contentsUrl = json['contents_url'] as String?,
        compareUrl = json['compare_url'] as String?,
        mergesUrl = json['merges_url'] as String?,
        archiveUrl = json['archive_url'] as String?,
        downloadsUrl = json['downloads_url'] as String?,
        issuesUrl = json['issues_url'] as String?,
        pullsUrl = json['pulls_url'] as String?,
        milestonesUrl = json['milestones_url'] as String?,
        notificationsUrl = json['notifications_url'] as String?,
        labelsUrl = json['labels_url'] as String?,
        releasesUrl = json['releases_url'] as String?,
        deploymentsUrl = json['deployments_url'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        pushedAt = json['pushed_at'] as String?,
        gitUrl = json['git_url'] as String?,
        sshUrl = json['ssh_url'] as String?,
        cloneUrl = json['clone_url'] as String?,
        svnUrl = json['svn_url'] as String?,
        homepage = json['homepage'],
        size = json['size'] as dynamic,
        stargazersCount =
            int.tryParse(json['stargazers_count'].toString()) ?? 0,
        watchersCount = json['watchers_count'] as dynamic,
        language = json['language'] as String?,
        hasIssues = json['has_issues'] as bool?,
        hasProjects = json['has_projects'] as bool?,
        hasDownloads = json['has_downloads'] as bool?,
        hasWiki = json['has_wiki'] as bool?,
        hasPages = json['has_pages'] as bool?,
        hasDiscussions = json['has_discussions'] as bool?,
        forksCount = json['forks_count'] as dynamic,
        mirrorUrl = json['mirror_url'],
        archived = json['archived'] as bool?,
        disabled = json['disabled'] as bool?,
        openIssuesCount = json['open_issues_count'] as dynamic,
        license = (json['license'] as Map<String, dynamic>?) != null
            ? License.fromJson(json['license'] as Map<String, dynamic>)
            : null,
        allowForking = json['allow_forking'] as bool?,
        isTemplate = json['is_template'] as bool?,
        webCommitSignoffRequired = json['web_commit_signoff_required'] as bool?,
        topics = json['topics'] as List?,
        visibility = json['visibility'] as String?,
        forks = json['forks'] as dynamic,
        openIssues = json['open_issues'] as dynamic,
        watchers = json['watchers'] as dynamic,
        defaultBranch = json['default_branch'] as String?,
        score = json['score'] as dynamic;
}

class Owner {
  final String? login;
  final dynamic id;
  final String? nodeId;
  final String? avatarUrl;
  final String? gravatarId;
  final String? url;
  final String? htmlUrl;
  final String? followersUrl;
  final String? followingUrl;
  final String? gistsUrl;
  final String? starredUrl;
  final String? subscriptionsUrl;
  final String? organizationsUrl;
  final String? reposUrl;
  final String? eventsUrl;
  final String? receivedEventsUrl;
  final String? type;
  final bool? siteAdmin;

  Owner({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.siteAdmin,
  });

  Owner.fromJson(Map<String, dynamic> json)
      : login = json['login'] as String?,
        id = json['id'] as dynamic,
        nodeId = json['node_id'] as String?,
        avatarUrl = json['avatar_url'] as String?,
        gravatarId = json['gravatar_id'] as String?,
        url = json['url'] as String?,
        htmlUrl = json['html_url'] as String?,
        followersUrl = json['followers_url'] as String?,
        followingUrl = json['following_url'] as String?,
        gistsUrl = json['gists_url'] as String?,
        starredUrl = json['starred_url'] as String?,
        subscriptionsUrl = json['subscriptions_url'] as String?,
        organizationsUrl = json['organizations_url'] as String?,
        reposUrl = json['repos_url'] as String?,
        eventsUrl = json['events_url'] as String?,
        receivedEventsUrl = json['received_events_url'] as String?,
        type = json['type'] as String?,
        siteAdmin = json['site_admin'] as bool?;

  Map<String, dynamic> toJson() => {
        'login': login,
        'id': id,
        'node_id': nodeId,
        'avatar_url': avatarUrl,
        'gravatar_id': gravatarId,
        'url': url,
        'html_url': htmlUrl,
        'followers_url': followersUrl,
        'following_url': followingUrl,
        'gists_url': gistsUrl,
        'starred_url': starredUrl,
        'subscriptions_url': subscriptionsUrl,
        'organizations_url': organizationsUrl,
        'repos_url': reposUrl,
        'events_url': eventsUrl,
        'received_events_url': receivedEventsUrl,
        'type': type,
        'site_admin': siteAdmin
      };
}

class License {
  final String? key;
  final String? name;
  final String? spdxId;
  final String? url;
  final String? nodeId;

  License({
    this.key,
    this.name,
    this.spdxId,
    this.url,
    this.nodeId,
  });

  License.fromJson(Map<String, dynamic> json)
      : key = json['key'] as String?,
        name = json['name'] as String?,
        spdxId = json['spdx_id'] as String?,
        url = json['url'] as String?,
        nodeId = json['node_id'] as String?;

  Map<String, dynamic> toJson() => {
        'key': key,
        'name': name,
        'spdx_id': spdxId,
        'url': url,
        'node_id': nodeId
      };
}
